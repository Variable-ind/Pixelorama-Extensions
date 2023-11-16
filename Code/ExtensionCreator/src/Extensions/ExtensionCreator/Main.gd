extends Node

var global :Node  # Needed for reference to "Global" node of Pixelorama (Used most of the time)
var creator_scene :Button

# This script acts as a setup for the extension
func _enter_tree() -> void:
	global = get_node_or_null("/root/Global")
	if global:
		var extension_container = global.control.find_node("Extensions")
		if extension_container:
			creator_scene = preload("res://src/Extensions/ExtensionCreator/elements/Instructions.tscn").instance()
			var parent = extension_container.get_node("ExtensionsHeader")
			parent.call_deferred("add_child", creator_scene)


func _exit_tree() -> void:
	if global:
		creator_scene.queue_free()
