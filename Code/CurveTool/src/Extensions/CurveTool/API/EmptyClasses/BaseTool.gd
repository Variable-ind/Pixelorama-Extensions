class_name BaseTool
extends VBoxContainer

## This script is not part of extension (it is used in union with the api)

var is_moving = false
var kname: String
var tool_slot = null  # Tools.Slot, can't have static typing due to cyclic errors
var cursor_text := ""
var _cursor := Vector2.INF

var _draw_cache: PoolVector2Array = []  # for storing already drawn pixels
var _for_frame := 0  # cache for which frame?

# Only use "_spacing_mode" and "_spacing" variables (the others are set automatically)
# The _spacing_mode and _spacing values are to be CHANGED only in the tool scripts (e.g Pencil.gd)
var _spacing_mode := false  # Enables spacing (continuous gaps between two strokes)
var _spacing := Vector2.ZERO  # Spacing between two strokes
var _stroke_dimensions := Vector2.ONE  # 2d vector containing _brush_size from Draw.gd
var _spacing_offset := Vector2.ZERO  # The "INITIAL" error between position and position.snapped()
onready var color_rect: ColorRect = $ColorRect


func draw_preview() -> void:
	pass


func snap_position(position: Vector2) -> Vector2:
	return Vector2.ZERO


func _create_polylines(bitmap: BitMap) -> Array:
	return []


func get_config() -> Dictionary:
	return {}
