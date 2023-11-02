## This script is not part of extension (it is used in union with the api)
# Initial version made by MrTriPie, has been modified by Overloaded.
tool
class_name ValueSlider
extends TextureProgress

enum { NORMAL, HELD, SLIDING, TYPING }

export var editable := true
export var prefix: String
export var suffix: String
# Size of additional snapping (applied in addition to Range's step).
# This should always be larger than step.
export var snap_step := 1.0
# If snap_by_default is true, snapping is enabled when Control is NOT held (used for sliding in
# larger steps by default, and smaller steps when holding Control).
# If false, snapping is enabled when Control IS held (used for sliding in smaller steps by
# default, and larger steps when holding Control).
export var snap_by_default := false
# If show_progress is true it will show the colored progress bar, good for values with a specific
# range. False will hide it, which is good for values that can be any number.
export var show_progress := true
export var show_arrows := true
export var echo_arrow_time := 0.075
# This will be replaced with input action strings in Godot 4.x
# Right now this is only used for changing the brush size with Control + Wheel
# In Godot 4.x, the shortcut will be editable
export var is_global := false

var state := NORMAL
var arrow_is_held := 0  # Used for arrow button echo behavior. Is 1 for ValueUp, -1 for ValueDown.

var _line_edit := LineEdit.new()
var _value_up_button := TextureButton.new()
var _value_down_button := TextureButton.new()
var _timer := Timer.new()


func _init() -> void:
	nine_patch_stretch = true
	stretch_margin_left = 3
	stretch_margin_top = 3
	stretch_margin_right = 3
	stretch_margin_bottom = 3
	theme_type_variation = "ValueSlider"

