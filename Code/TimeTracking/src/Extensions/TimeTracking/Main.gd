extends Node

var item_id: int
var statistics_dialog: AcceptDialog

# This script acts as a setup for the extension
func _ready() -> void:
	var type = ExtensionsApi.menu.HELP
	statistics_dialog = preload(
		"res://src/Extensions/TimeTracking/StatisticDialog/StatisticDialog.tscn"
	).instance()
	ExtensionsApi.dialog.get_dialogs_parent_node().add_child(statistics_dialog)
	item_id = ExtensionsApi.menu.add_menu_item(type, "Project Statistics", statistics_dialog)


func _exit_tree() -> void:  # Extension is being uninstalled or disabled
	# remember to remove things that you added using this extension
	ExtensionsApi.menu.remove_menu_item(ExtensionsApi.menu.HELP, item_id)
	statistics_dialog.prepare_exit_tree()
	statistics_dialog.queue_free()
