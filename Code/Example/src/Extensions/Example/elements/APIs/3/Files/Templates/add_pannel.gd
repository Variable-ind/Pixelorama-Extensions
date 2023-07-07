extends Node

# some references to nodes that will be created later
var panel


# This script acts as a setup for the extension
func _enter_tree() -> void:
	# add a test panel as a tab  (this is an example) the tab is located at the same
	# place as the (Tools tab) by default
	panel = Panel.new()
	ExtensionsApi.panel.add_node_as_tab(panel)


func _exit_tree() -> void:  # Extension is being uninstalled or disabled
	# remember to remove things that you added using this extension
	ExtensionsApi.panel.remove_node_from_tab(panel)
