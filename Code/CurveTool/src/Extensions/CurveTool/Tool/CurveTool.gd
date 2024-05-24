extends "res://src/Tools/Draw.gd"

var _curve := Curve2D.new()  ## The [Curve2D] responsible for the shape of the curve being drawn.
var _drawing := false  ## Set to true when a curve is being drawn.
var _fill := false  ## When true, the inside area of the curve gets filled.
var _editing_bezier := false  ## Needed to determine when to show the control points preview line.
var _editing_out_control_point := false  ## True when controlling the out control point only.
var _thickness := 1  ## The thickness of the curve.
var _last_mouse_position := Vector2.INF  ## The last position of the mouse
var global = ExtensionsApi.general.get_global()


func _init() -> void:
	_drawer.color_op = Drawer.ColorOp.new()
	update_indicator()


func update_brush() -> void:
	pass


func _on_Thickness_value_changed(value: int) -> void:
	_thickness = value

	update_indicator()
	update_config()
	save_config()


func _on_fill_checkbox_toggled(toggled_on: bool) -> void:
	_fill = toggled_on
	update_config()
	save_config()


func update_indicator() -> void:
	var bitmap := BitMap.new()
	bitmap.create(Vector2.ONE * _thickness)
	bitmap.set_bit_rect(Rect2(Vector2.ZERO, Vector2.ONE * _thickness), true)
	_indicator = bitmap
	_polylines = _create_polylines(_indicator)


func get_config() -> Dictionary:
	var config := .get_config()
	config["thickness"] = _thickness
	return config


func set_config(config: Dictionary) -> void:
	.set_config(config)
	_thickness = config.get("thickness", _thickness)


func update_config() -> void:
	.update_config()
	$ThicknessSlider.value = _thickness


func _input(event: InputEvent) -> void:
	if _drawing:
		if event is InputEventMouseMotion:
			_last_mouse_position = global.canvas.current_pixel.floor()
			if global.mirror_view:
				_last_mouse_position.x = global.current_project.size.x - 1 - _last_mouse_position.x
		elif event is InputEventMouseButton:
			if event.doubleclick and event.button_index == tool_slot.button:
				$DoubleClickTimer.start()
				_draw_shape()
		else:
			if event.is_action_pressed("shape_perfect"):
				_editing_out_control_point = true
			elif event.is_action_released("shape_perfect"):
				_editing_out_control_point = false
			if event.is_action_pressed("change_tool_mode"):  # Control removes the last added point
				if _curve.get_point_count() > 1:
					_curve.remove_point(_curve.get_point_count() - 1)


func draw_start(pos: Vector2) -> void:
	if !$DoubleClickTimer.is_stopped():
		return
	pos = snap_position(pos)
	.draw_start(pos)
	if Input.is_action_pressed("shape_displace"):
		_picking_color = true
		_pick_color(pos)
		return
	global.canvas.selection.transform_content_confirm()
	update_mask()
	if !_drawing:
		_drawing = true
	_curve.add_point(pos)


func draw_move(pos: Vector2) -> void:
	pos = snap_position(pos)
	.draw_move(pos)
	if _picking_color:  # Still return even if we released Alt
		if Input.is_action_pressed("shape_displace"):
			_pick_color(pos)
		return
	if _drawing:
		_editing_bezier = true
		var current_position := _curve.get_point_position(_curve.get_point_count() - 1) - Vector2(pos)
		if not _editing_out_control_point:
			_curve.set_point_in(_curve.get_point_count() - 1, current_position)
		_curve.set_point_out(_curve.get_point_count() - 1, -current_position)


func draw_end(pos: Vector2) -> void:
	_editing_bezier = false
	if _is_hovering_first_position(pos) and _curve.get_point_count() > 1:
		_draw_shape()
	.draw_end(pos)


func draw_preview() -> void:
	if not _drawing:
		return
	var canvas: Node2D = global.canvas.previews
	var pos := canvas.position
	var canvas_scale := canvas.scale
	if global.mirror_view:  # This fixes previewing in mirror mode
		pos.x = pos.x + global.current_project.size.x
		canvas_scale.x = -1

	var points := _bezier()
	canvas.draw_set_transform(pos, canvas.rotation, canvas_scale)
	var indicator := _fill_bitmap_with_points(points, global.current_project.size)

	for line in _create_polylines(indicator):
		canvas.draw_polyline(PoolVector2Array(line), Color.black)

	canvas.draw_set_transform(canvas.position, canvas.rotation, canvas.scale)

	var circle_radius: Vector2 = 5 * global.camera.zoom
	if _is_hovering_first_position(_last_mouse_position):
		var circle_center := _curve.get_point_position(0)
		if global.mirror_view:  # This fixes previewing in mirror mode
			circle_center.x = global.current_project.size.x - circle_center.x - 1
		circle_center += Vector2.ONE * 0.5
		draw_empty_circle(canvas, circle_center, circle_radius * 2.0, Color.black)
	if _editing_bezier:
		var current_position := _curve.get_point_position(_curve.get_point_count() - 1)
		var start := current_position
		if _curve.get_point_count() > 1:
			start = current_position + _curve.get_point_in(_curve.get_point_count() - 1)
		var end := current_position + _curve.get_point_out(_curve.get_point_count() - 1)
		if global.mirror_view:  # This fixes previewing in mirror mode
			current_position.x = global.current_project.size.x - current_position.x - 1
			start.x = global.current_project.size.x - start.x - 1
			end.x = global.current_project.size.x - end.x - 1

		canvas.draw_line(start, current_position, Color.black)
		canvas.draw_line(current_position, end, Color.black)
		draw_empty_circle(canvas, start, circle_radius, Color.black)
		draw_empty_circle(canvas, end, circle_radius, Color.black)


func _draw_shape() -> void:
	var points := _bezier()
	prepare_undo("Draw Shape")
	for point in points:
		# Reset drawer every time because pixel perfect sometimes breaks the tool
		_drawer.reset()
		# Draw each point offsetted based on the shape's thickness
		draw_tool(point)
	if _fill:
		var v := Vector2()
		var image_size: Vector2 = global.current_project.size
		for x in image_size.x:
			v.x = x
			for y in image_size.y:
				v.y = y
				if Geometry.is_point_in_polygon(v, points):
					draw_tool(v)
	_curve.clear_points()
	_drawing = false
	_editing_out_control_point = false
	commit_undo()


## Get the [member _curve]'s baked points, and draw lines between them using [method _fill_gap].
func _bezier() -> Array:
	var last_pixel = global.canvas.current_pixel.floor()
	if global.mirror_view:
		# Mirror the last point of the curve
		last_pixel.x = (global.current_project.size.x - 1) - last_pixel.x
	_curve.add_point(last_pixel)
	var points := _curve.get_baked_points()
	_curve.remove_point(_curve.get_point_count() - 1)
	var final_points: Array = []
	for i in points.size() - 1:
		var point1 := points[i]
		var point2 := points[i + 1]
		final_points.append_array(_fill_gap(point1.floor(), point2.floor()))
	return final_points


## Fills the gap between [param point_a] and [param point_b] using Bresenham's line algorithm.
## Takes the [member _thickness] into account.
func _fill_gap(point_a: Vector2, point_b: Vector2) -> PoolVector2Array:
	var array := []
	var dx := int(abs(point_b.x - point_a.x))
	var dy := int(-abs(point_b.y - point_a.y))
	var err := dx + dy
	var e2 := err << 1
	var sx = 1 if point_a.x < point_b.x else -1
	var sy = 1 if point_a.y < point_b.y else -1
	var x = point_a.x
	var y = point_a.y

	var start := point_a - Vector2.ONE * (_thickness >> 1)
	var end := start + Vector2.ONE * _thickness
	for yy in range(start.y, end.y):
		for xx in range(start.x, end.x):
			array.append(Vector2(xx, yy))

	while !(x == point_b.x && y == point_b.y):
		e2 = err << 1
		if e2 >= dy:
			err += dy
			x += sx
		if e2 <= dx:
			err += dx
			y += sy

		var pos := Vector2(x, y)
		start = pos - Vector2.ONE * (_thickness >> 1)
		end = start + Vector2.ONE * _thickness
		for yy in range(start.y, end.y):
			for xx in range(start.x, end.x):
				array.append(Vector2(xx, yy))

	return PoolVector2Array(array)


func _fill_bitmap_with_points(points: Array, bitmap_size: Vector2) -> BitMap:
	var bitmap := BitMap.new()
	bitmap.create(bitmap_size)

	for point in points:
		if point.x < 0 or point.y < 0 or point.x >= bitmap_size.x or point.y >= bitmap_size.y:
			continue
		bitmap.set_bit(point, 1)

	return bitmap


func _is_hovering_first_position(pos: Vector2) -> bool:
	return _curve.get_point_count() > 0 and _curve.get_point_position(0) == pos


# Thanks to
# https://www.reddit.com/r/godot/comments/3ktq39/drawing_empty_circles_and_curves/cv0f4eo/
func draw_empty_circle(
	canvas: CanvasItem, circle_center: Vector2, circle_radius: Vector2, color: Color
) -> void:
	var draw_counter := 1
	var line_origin := Vector2()
	var line_end := Vector2()
	line_origin = circle_radius + circle_center

	while draw_counter <= 360:
		line_end = circle_radius.rotated(deg2rad(draw_counter)) + circle_center
		canvas.draw_line(line_origin, line_end, color)
		draw_counter += 1
		line_origin = line_end

	line_end = circle_radius.rotated(TAU) + circle_center
	canvas.draw_line(line_origin, line_end, color)
