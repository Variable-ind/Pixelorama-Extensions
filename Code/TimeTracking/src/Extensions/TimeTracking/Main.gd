extends Node

var item_id: int
var statistics_dialog: AcceptDialog

@onready var extension_api = get_node_or_null("/root/ExtensionsApi")

# This script acts as a setup for the extension
func _ready() -> void:
	var type = extension_api.menu.HELP
	statistics_dialog = preload(
		"res://src/Extensions/TimeTracking/StatisticDialog/StatisticDialog.tscn"
	).instantiate()
	extension_api.dialog.get_dialogs_parent_node().add_child(statistics_dialog)
	item_id = extension_api.menu.add_menu_item(type, "Project Statistics", statistics_dialog)


func _exit_tree() -> void:  # Extension is being uninstalled or disabled
	# remember to remove things that you added using this extension
	extension_api.menu.remove_menu_item(extension_api.menu.HELP, item_id)
	statistics_dialog.extension_about_to_shutdown()
	statistics_dialog.queue_free()
