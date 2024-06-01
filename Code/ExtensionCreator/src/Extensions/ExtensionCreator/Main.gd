extends Node

var global :Node  # Needed for reference to "Global" node of Pixelorama (Used most of the time)
var creator_dialog :Window
var item_id: int

# This script acts as a setup for the extension
func _enter_tree() -> void:
	item_id = ExtensionsApi.menu.add_menu_item(
		ExtensionsApi.menu.HELP, "Creating an Extension", self
	)
	creator_dialog = preload("res://src/Extensions/ExtensionCreator/elements/Instructions.tscn").instantiate()
	ExtensionsApi.dialog.get_dialogs_parent_node().call_deferred("add_child", creator_dialog)


func menu_item_clicked():
	creator_dialog.popup_centered()


func _exit_tree() -> void:
	# remember to remove things that you added using this extension
	ExtensionsApi.menu.remove_menu_item(ExtensionsApi.menu.HELP, item_id)
	creator_dialog.queue_free()
