extends Node

# This is a Virtual Api that is used to make extensions
enum { FILE, EDIT, SELECT, IMAGE, VIEW, WINDOW, HELP }


func get_api_version() -> int:
	# Returns the api version of pixelorama
	return 1


func get_pixelorama_version() -> String:
	# Returns the version of pixelorama
	return "0.10.0"


func dialog_open(open: bool) -> void:
	# Tell pixelorama that a dialog is being opened
	pass


func get_current_project():
	# Returns the current project (type: Project)
	pass


func get_global():
	# Returns the Global autoload used by pixelorama
	pass


func get_extensions_node() -> Node:
	# Returns the Extensions Node (the parent of the extension's Main.tscn)
	return Node.new()


func get_dockable_container_ui() -> Node:
	# Returns the DockableContainer node
	return Node.new()


func get_config_file() -> ConfigFile:
	# config_file contains all the settings (Brushes, sizes, preferences, etc...)
	return ConfigFile.new()


func get_canvas():
	# Returns the canvas
	pass


func get_dialogs_parent_node() -> Node:
	# Returns the Dialog node (All dialogs are children of Dialog node)
	return Node.new()


# Dockable container methods
func add_node_as_tab(node: Node, alongside_node: String) -> void:
	# Adds a node as a tab in the same place as an already existing "alongside_node"
	pass


func remove_node_from_tab(node: Node) -> void:
	# Removes the node from the DockableContainer
	pass


# Menu methods
func add_menu_item(menu_type: int, item_name: String, item_metadata, item_id := -1) -> int:
	# Adds an entry of name "item_name"
	# as a "menu_type" (FILE, EDIT, SELECT, IMAGE, VIEW, WINDOW, HELP)

	# Metadata should be of type "Object" which is usually a popup
	# and it should also have a method named "menu_item_clicked"

	# "item_idx" of the added entry is returned
	return 0


func remove_menu_item(menu_type: int, item_idx: int) -> void:
	# removes an entry at "item_idx" from the menu_type (FILE, EDIT, SELECT, IMAGE, VIEW, WINDOW, HELP)
	pass


# Tool methods
func add_tool(
	tool_name: String,
	display_name: String,
	shortcut: String,
	scene: PackedScene,
	extra_hint := "",
	extra_shortucts := []
) -> void:
	# adds a tool with the above detail
	pass


func remove_tool(tool_name: String) -> void:
	# removes a tool with name "tool_name"
	pass


# Theme methods
func add_theme(theme: Theme) -> void:
	# adds a theme
	pass


func find_theme_index(theme: Theme) -> int:
	# returns index of a theme in preferences
	return 0


func get_theme() -> Theme:
	# returns the current theme
	return Theme.new()


func set_theme(idx: int) -> bool:
	# sets a theme located at a given "idx" in preferences

	# if theme set successfully then return true, else false
	return false


func remove_theme(theme: Theme) -> void:
	# remove a theme from preferences
	pass
