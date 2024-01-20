extends Node

var color_change: VBoxContainer


func _enter_tree() -> void:  # when the extension is being enabled
	var api = get_node_or_null("/root/ExtensionsApi")
	if !api:
		return
	# Find the colorpicker node
	var colorpicker = api.general.get_global().control.find_child("Color Picker")

	# Place the replace_button at a comfortable place
	color_change = preload("res://src/Extensions/Swappy/Elements/ColorChange.tscn").instantiate()
	color_change.api = api
	color_change.colorpicker = colorpicker
	colorpicker.color_buttons.add_child(color_change)
	colorpicker.color_buttons.move_child(color_change, 0)


func _exit_tree() -> void:  # when the extension is being disabled/closed
	# remove replace_button
	color_change.queue_free()
