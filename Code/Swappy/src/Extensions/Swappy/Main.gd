extends Node

var color_change: VBoxContainer


func _enter_tree() -> void:  # when the extension is being enabled
	# Find the colorpicker node
	var colorpicker = ExtensionsApi.general.get_global().control.find_child("Color Pickers")

	# Place the replace_button at a comfortable place
	color_change = preload("res://src/Extensions/Swappy/Elements/ColorChange.tscn").instantiate()
	colorpicker.get_child(0).add_child(color_change)
	color_change.colorpicker = colorpicker
	colorpicker.get_child(0).move_child(color_change, 0)


func _exit_tree() -> void:  # when the extension is being disabled/closed
	# remove replace_button
	color_change.queue_free()
