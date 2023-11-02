extends "res://src/Tools/ShapeDrawer.gd"

var square := false
var mark_center := false


func get_config() -> Dictionary:
	var config: Dictionary = .get_config()
	config["square"] = square
	config["mark_center"] = mark_center
	return config


func set_config(config: Dictionary) -> void:
	.set_config(config)
	square = config.get("square", square)
	mark_center = config.get("mark_center", mark_center)


func update_config() -> void:
	.update_config()
	$Square.pressed = square
	$CenterMark.pressed = mark_center


func _get_shape_points_filled(shape_size: Vector2) -> PoolVector2Array:
	var t_of := _thickness - 1
	var pos = Vector2.ZERO
	var effective_size := shape_size + (Vector2.ONE * t_of)
	# calculate boundary points (this assumes corners are pointy)
	var boundary := Array()
	if shape_size.x == 1 or shape_size.y == 1:
		append_gap(pos, pos + shape_size - Vector2.ONE, boundary)
	else:
		var offset := Vector2.ZERO
		if square:
			offset = Vector2i(_thickness / 2.0, _thickness / 2.0)
		var corners = _get_corners(pos + offset, shape_size)
		for corner_idx in corners.size():
			var next = corner_idx + 1
			if next == corners.size():
				next = 0
			if square:
				add_line(corners[corner_idx], corners[next], boundary)
			else:
				append_gap(corners[corner_idx], corners[next], boundary)
	# get filled polygon
	var filled_poly := PoolVector2Array()
	for point in boundary:
		filled_poly.append(point)
	var v := Vector2()
	for x in effective_size.x:
		v.x = x
		for y in effective_size.y:
			v.y = y
			if Geometry.is_point_in_polygon(v, boundary):
				filled_poly.append(v)
	return filled_poly


func _get_shape_points(shape_size: Vector2) -> PoolVector2Array:
	var points := PoolVector2Array()
	if _thickness == 1:
		points.append_array(_get_blunt_isobox_points(Vector2(0, 0), shape_size))
	else:
		if square:
			points.append_array(_get_blunt_isobox_points(Vector2(0, 0), shape_size))
		else:
			points.append_array(_get_sharp_isobox_points(Vector2(0, 0), shape_size))
	if mark_center:
		var t_of := _thickness - 1
		var effective_size := shape_size + (Vector2.ONE * t_of)
		points.append(Rect2(Vector2.ZERO, effective_size).get_center())
	return points


func _get_blunt_isobox_points(pos: Vector2, shape_size: Vector2) -> Array:
	var points := Array()
	# the top and left corners needs some offset to fit in rect defined by (pos, shape_size)
	var offset = Vector2i(_thickness / 2.0, _thickness / 2.0)
	var corners = _get_corners(pos + offset, shape_size)
	for corner_idx in corners.size():
		var next = corner_idx + 1
		if next == corners.size():
			next = 0
		add_line(corners[corner_idx], corners[next], points)
	return points


func _get_sharp_isobox_points(pos: Vector2, shape_size: Vector2) -> Array:
	# get filled shape
	var offset := Vector2i(_thickness / 2.0, _thickness / 2.0)
	var top_bound := Array()
	var top_bound_size = shape_size
	var corners = _get_corners(pos, top_bound_size)
	if top_bound_size.x == 1 or top_bound_size.y == 1:
		append_gap(pos + offset, pos + offset + top_bound_size - Vector2.ONE, top_bound)
	else:
		for corner_idx in corners.size():
			var next = corner_idx + 1
			if next == corners.size():
				next = 0
			append_gap(corners[corner_idx] + offset, corners[next] + offset, top_bound)

	# get filled polygon
	var t_of := _thickness - 1
	var effective_size := shape_size + (Vector2.ONE * t_of)
	var lower_bound = get_inner_bound(corners, pos, shape_size, offset)
	var filled_poly := Array()
	filled_poly.append_array(top_bound)
	filled_poly.append_array(lower_bound)
#	return filled_poly
	var v := Vector2()
	for x in effective_size.x + 1:
		v.x = x
		for y in effective_size.y + 1:
			v.y = y
			if Geometry.is_point_in_polygon(v, top_bound):
				if !Geometry.is_point_in_polygon(v, lower_bound):
					filled_poly.append(v)
	return filled_poly


# Helper functions
func _get_corners(pos: Vector2, shape_size: Vector2, offset := Vector2.ZERO) -> Array:
	var rect = Rect2(pos, shape_size)
	var top = Vector2i(rect.get_center().x, rect.position.y)
	var bottom = Vector2i(rect.get_center().x, rect.end.y) + Vector2.UP
	var left = Vector2i(rect.position.x, rect.get_center().y)
	var right = Vector2i(rect.end.x, rect.get_center().y) + Vector2.LEFT
	var corners: Array = [top, right, bottom, left]
	if int(shape_size.x) % 2 == 0:
		corners.insert(corners.find(top), top + Vector2.LEFT)
		corners.insert(corners.find(bottom) + 1, bottom + Vector2.LEFT)
	if int(shape_size.y) % 2 == 0:
		corners.insert(corners.find(right), right + Vector2.UP)
		corners.insert(corners.find(left) + 1, left + Vector2.UP)
	for corner_idx in corners.size():
		corners[corner_idx] += offset
	return corners


func get_inner_bound(corners: Array, pos: Vector2, upper_size: Vector2, offset: Vector2) -> PoolVector2Array:
	# get inner blunt boungary
	var lower_bound := Array()
	if upper_size.x > _thickness * 2 or upper_size.y > _thickness * 2:
		var ratio := upper_size.x / upper_size.y
		var even_offset = 1 - int(_thickness) % 2
		var inner_corners = []
		for corner in corners:
			var inner: Vector2
			if corner.x == pos.x:  # Top
				inner = corner + Vector2i(_thickness, 0)
				if upper_size.x < upper_size.y:
					inner.x = corner.x + int(_thickness * ratio) + even_offset
			elif corner.x == pos.x + upper_size.x - 1:  # Bottom
				inner = corner - Vector2i(_thickness, 0)
				if upper_size.x < upper_size.y:
					inner.x = corner.x - int(_thickness * ratio) - even_offset
			elif corner.y == pos.y:  # Left
				inner = corner + Vector2i(0, _thickness)
				if upper_size.x > upper_size.y:
					inner.y = corner.y + int(_thickness / ratio) + even_offset
			elif corner.y == pos.y + upper_size.y - 1:  # Right
				inner = corner - Vector2i(0, _thickness)
				if upper_size.x > upper_size.y:
					inner.y = corner.y - int(_thickness / ratio) - even_offset
			inner_corners.append(inner)
		for corner_idx in inner_corners.size():
			var next = corner_idx + 1
			if next == corners.size():
				next = 0
			append_gap(inner_corners[corner_idx] + offset, inner_corners[next] + offset, lower_bound)
	return PoolVector2Array(lower_bound)


func Vector2i(x, y) -> Vector2:
	return Vector2(int(x), int(y))


# Bresenham's Algorithm
# Thanks to https://godotengine.org/qa/35276/tile-based-line-drawing-algorithm-efficiency
func append_gap(start: Vector2, end: Vector2, array: Array) -> void:
	var dx: int = abs(end.x - start.x)
	var dy: int = -abs(end.y - start.y)
	var err: int = dx + dy
	var e2 := err << 1
	var sx := 1 if start.x < end.x else -1
	var sy := 1 if start.y < end.y else -1
	var x := start.x
	var y := start.y
	while !(x == end.x && y == end.y):
		e2 = err << 1
		if e2 >= dy:
			err += dy
			x += sx
		if e2 <= dx:
			err += dx
			y += sy
		if !Vector2(x, y) in array:
			array.append(Vector2(x, y))


func add_line(src: Vector2, dest: Vector2, array: Array):
	var dx := int(abs(dest.x - src.x))
	var dy := int(-abs(dest.y - src.y))
	var err := dx + dy
	var e2 := err << 1
	var sx = 1 if src.x < dest.x else -1
	var sy = 1 if src.y < dest.y else -1
	var x = src.x
	var y = src.y

	var start := src - Vector2.ONE * (_thickness >> 1)
	var end := start + Vector2.ONE * _thickness
	for yy in range(start.y, end.y):
		for xx in range(start.x, end.x):
			array.append(Vector2(xx, yy))

	while !(x == dest.x && y == dest.y):
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


func _on_Pointy_toggled(button_pressed: bool) -> void:
	square = button_pressed
	update_config()
	save_config()


func _on_CenterMark_toggled(button_pressed: bool) -> void:
	mark_center = button_pressed
	update_config()
	save_config()


func _on_Square_toggled(button_pressed: bool) -> void:
	square = button_pressed
