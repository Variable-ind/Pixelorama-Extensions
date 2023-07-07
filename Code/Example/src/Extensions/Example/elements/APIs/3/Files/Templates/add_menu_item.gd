extends Node

var item_id: int

# This script acts as a setup for the extension
func _enter_tree() -> void:
	var type = ExtensionsApi.menu.HELP

	item_id = ExtensionsApi.menu.add_menu_item(type, "Show Message", self)
	# the 3rd argument (in this case "self") will try to call "menu_item_clicked"
	# (if it is present)


func menu_item_clicked():
	# Do some stuff
	ExtensionsApi.dialog.show_error("You Tickled Me :)")


func _exit_tree() -> void:  # Extension is being uninstalled or disabled
	# remember to remove things that you added using this extension
	ExtensionsApi.menu.remove_menu_item(ExtensionsApi.menu.HELP, item_id)
