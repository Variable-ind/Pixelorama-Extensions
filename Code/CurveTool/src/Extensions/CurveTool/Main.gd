extends Node

# NOTE: (ExtensionsApi) and get_node_or_null("/root/ExtensionsApi") mean the same thing.

# This script acts as a setup for the extension
func _enter_tree() -> void:
	ExtensionsApi.tools.add_tool(
		"CurveTool",
		"Curve Tool",
		"curvetool",
		preload("res://src/Extensions/CurveTool/Tool/CurveTool.tscn"),
		"""Draws bezier curves
Press %s/%s to add new points
Press and drag to control the curvature
Press %s to remove the last added point""" %
	[
		get_action_string("activate_left_tool"),
		get_action_string("activate_right_tool"),
		get_action_string("change_tool_mode"),
	],
		[],
		[0]
	)
	pass

func get_action_string(action_key: String) -> String:
	var key_string := "None"
	var events := InputMap.get_action_list(action_key)
	if events.size() > 0:
		for event in events:
			if event is InputEventMouseButton:
				if event.button_index == BUTTON_LEFT:
					key_string = "Left Mouse Button"
				elif event.button_index == BUTTON_RIGHT:
					key_string = "Right Mouse Button"
				elif event.button_index == BUTTON_MIDDLE:
					key_string = "Middle Mouse Button"
				break
			elif event is InputEventKey:
				key_string = OS.get_scancode_string(event.get_scancode_with_modifiers())
				break
	return key_string


func _exit_tree() -> void:  # Extension is being uninstalled or disabled
	ExtensionsApi.tools.remove_tool("CurveTool")
	# remember to remove things that you added using this extension
	pass
