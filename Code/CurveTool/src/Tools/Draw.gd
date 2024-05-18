extends BaseTool

## This script is not part of extension (it is used in union with the api)

var _brush
var _brush_size := 1
var _brush_size_dynamics := 1
var _cache_limit := 3
var _brush_interpolate := 0
var _brush_image := Image.new()
var _orignal_brush_image := Image.new()  # contains the original _brush_image, without resizing
var _brush_texture := ImageTexture.new()
var _strength := 1.0
var _picking_color := false

var _undo_data := {}
var _drawer := Drawer.new()
var _mask := PoolRealArray()
var _mirror_brushes := {}

var _draw_line := false
var _line_start := Vector2.ZERO
var _line_end := Vector2.ZERO

var _indicator := BitMap.new()
var _polylines := []
var _line_polylines := []

# Memorize some stuff when doing brush strokes
var _stroke_project: Project
var _stroke_images := []  # Array of Images
var _is_mask_size_zero := true
var _circle_tool_shortcut: PoolVector2Array


func save_config():
	pass


func _prepare_tool() -> void:
	pass


func _draw_tool(position: Vector2) -> PoolVector2Array:
	return PoolVector2Array()


func _compute_draw_tool_pixel(position: Vector2) -> PoolVector2Array:
	return PoolVector2Array()


func _compute_draw_tool_circle(position: Vector2, fill := false) -> PoolVector2Array:
	return PoolVector2Array()


func prepare_undo(action: String) -> void:
	pass


func update_line_polylines(start: Vector2, end: Vector2) -> void:
	pass


func _line_angle_constraint(start: Vector2, end: Vector2) -> Dictionary:
	return {}


func update_mask(can_skip := true) -> void:
	pass


func _pick_color(position: Vector2) -> void:
	pass


func commit_undo() -> void:
	pass


func draw_tool(position: Vector2) -> void:
	pass
