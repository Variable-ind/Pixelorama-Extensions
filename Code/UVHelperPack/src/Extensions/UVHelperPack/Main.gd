extends Node

var preview_dialog # Its a kind of "Custom Dialog" i designed myself
var apply_dialog # Applies a Map to UV image
var menu_idx :int

# This script acts as a setup for the extension
func _enter_tree() -> void:
	# Adding Tools
	ExtensionsApi.tools.add_tool(
		"UVLineTool",  # Tool Name
		"UV Line Tool",  # Display Name
		"",  # Shortcut
		preload("res://src/Extensions/UVHelperPack/elements/line/LineTool.tscn"),  # Scene
		"""Hold %s to snap the angle of the line
Hold %s to center the shape on the click origin
Hold %s to displace the shape's origin""",  # Extra Hint
		["shape_perfect", "shape_center", "shape_displace"],  # Extra_shortucts
		[0]  # LayerType
	)

	ExtensionsApi.tools.add_tool(
		"UVColorPicker",  # Tool Name
		"UV Color Picker",  # Display Name
		"",  # Shortcut
		preload("res://src/Extensions/UVHelperPack/elements/colorpicker/ColorPicker.tscn"),  # Scene
		"Select a color from a pixel of the sprite",  # Extra Hint
		[],  # Extra_shortucts
		[0]  # LayerType
	)

	var parent = ExtensionsApi.general.get_global().control.get_node("Dialogs")
	# Adding Apply map to uv Dialog
	apply_dialog = preload("res://src/Extensions/UVHelperPack/elements/ApplyMapDialog/ApplyMap.tscn").instance()
	parent.call_deferred("add_child", apply_dialog)
	apply_dialog.main = self
	menu_idx = ExtensionsApi.menu.add_menu_item(3, "Apply Map texture", apply_dialog)

	# Preview
	preview_dialog = preload("res://src/Extensions/UVHelperPack/elements/preview/Preview.tscn").instance()
	parent.call_deferred("add_child", preview_dialog)
	preview_dialog.show()
	preview_dialog.main = self


func image_menu_idx_pressed(idx :int):
	if idx == menu_idx: # just a random id :)
		apply_dialog.popup(Rect2(preview_dialog.rect_position, apply_dialog.rect_size))
		ExtensionsApi.dialog.dialog_open(true)


func _exit_tree() -> void:
	preview_dialog.queue_free()
	apply_dialog.queue_free()
	ExtensionsApi.tools.remove_tool("UVLineTool")
	ExtensionsApi.tools.remove_tool("UVColorPicker")
	ExtensionsApi.menu.remove_menu_item(3, menu_idx)
