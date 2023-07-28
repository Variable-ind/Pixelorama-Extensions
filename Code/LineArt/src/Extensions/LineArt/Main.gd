extends Node

var item_id: int
var lineart_dialog: ImageEffect

# This script acts as a setup for the extension
func _enter_tree() -> void:
	var type = ExtensionsApi.menu.IMAGE

	item_id = ExtensionsApi.menu.add_menu_item(type, "Make LineArt", self)

	lineart_dialog = preload("res://src/Extensions/LineArt/Assets/Dialog/LineArtDialog.tscn").instance()
	var dialog_parent = ExtensionsApi.general.get_global().control.get_node("Dialogs/ImageEffects")
	dialog_parent.add_child(lineart_dialog)
	# the 3rd argument (in this case "self") will try to call "menu_item_clicked"
	# (if it is present)



func menu_item_clicked():
	# Do some stuff
	lineart_dialog.popup_centered()


func _exit_tree() -> void:  # Extension is being uninstalled or disabled
	# remember to remove things that you added using this extension
	ExtensionsApi.menu.remove_menu_item(ExtensionsApi.menu.IMAGE, item_id)
	lineart_dialog.queue_free()
