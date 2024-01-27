extends Node

# This script acts as a setup for the extension
func _enter_tree() -> void:
	ExtensionsApi.tools.add_tool(
		"DiamondTool",
		"Diamond Tool",
		"diamondtool",
		preload("res://src/Extensions/DiamondTool/Tool/DiamondTool.tscn"),
		"""Hold %s to snap the angle of the line
Hold %s to center the shape on the click origin
Hold %s to displace the shape's origin""",
		["shape_perfect", "shape_center", "shape_displace"],
		[0]
	)


func _exit_tree() -> void:  # Extension is being uninstalled or disabled
	ExtensionsApi.tools.remove_tool("DiamondTool")
