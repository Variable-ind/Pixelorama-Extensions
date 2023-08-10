# gdlint: ignore=max-public-methods
extends Node

# use these variables in your extension to access the api
var general := GeneralAPI.new()
var menu := MenuAPI.new()
var dialog := DialogAPI.new()
var panel := PanelAPI.new()
var theme := ThemeAPI.new()
var tools := ToolAPI.new()
var selection := SelectionAPI.new()
var project := ProjectAPI.new()
var exports := ExportAPI.new()
var signals := SignalsAPI.new()


# The Api Methods Start Here
func get_api_version() -> int:
	# Returns the api version of pixelorama
	return 3


class GeneralAPI:
	# Version And Config
	func get_pixelorama_version() -> String:
		# Returns the version of pixelorama
		return "0.11.0"

	func get_config_file() -> ConfigFile:
		# config_file contains all the settings (Brushes, sizes, preferences, etc...)
		return ConfigFile.new()

	# Nodes
	func get_global():
		# Returns the Global autoload used by pixelorama
		# (Global contains references to the important UI elements along with some global properties)
		pass

	func get_drawing_algos():
		# returns the DrawingAlgos autoload used by pixelorama
		pass

	func get_shader_image_effect():
		# gices you a new ShaderImageEffect class. this class can apply shader to an image
		# it has contains a method
		# generate_image(img: Image, shader: Shader, params: Dictionary, size: Vector2)
		## PARAMETERS
		## img --> image that the shader will be pasted to (Empty Image of size same as project)
		## shader --> preload of the shader
		## params --> a dictionary of params used by the shader
		## size --> It is the project's size
		pass

	func get_extensions_node() -> Node:
		# Returns the Extensions Node (the parent of the extension's Main.tscn)
		return Node.new()

	func get_canvas():
		# Returns the canvas
		pass


class MenuAPI:
	enum { FILE, EDIT, SELECT, IMAGE, VIEW, WINDOW, HELP }

	func add_menu_item(menu_type: int, item_name: String, item_metadata, item_id := -1) -> int:
		# item_metadata is usually a popup node you want to appear when you click the item_name
		# that popup should also have an (menu_item_clicked) function inside it's script
		# "item_idx" of the added entry is returned
		return 0

	func remove_menu_item(menu_type: int, item_idx: int) -> void:
		# removes an entry at "item_idx" from the menu_type (FILE, EDIT, SELECT, IMAGE, VIEW, WINDOW, HELP)
		pass


class DialogAPI:
	func show_error(text: String) -> void:
		# shows an alert dialog with the given "text"
		# useful for displaying messages like "Incompatible API" etc...
		pass

	func get_dialogs_parent_node() -> Node:
		# returns the node that is the parent of the dialog used in pixelorama
		return Node.new()

	func dialog_open(open: bool) -> void:
		# Tell pixelorama that a dialog is being opened
		pass


class PanelAPI:
	func set_tabs_visible(visible: bool) -> void:
		# sets the visibility of tabs
		pass

	func get_tabs_visible() -> bool:
		# get the visibility of tabs
		return false

	func add_node_as_tab(node: Node) -> void:
		# Adds a "node" as a tab
		pass

	func remove_node_from_tab(node: Node) -> void:
		# Removes the "node" from the DockableContainer
		pass


class ThemeAPI:
	func add_theme(theme: Theme) -> void:
		# Adds a theme
		pass

	func find_theme_index(theme: Theme) -> int:
		# Returns index of a theme in preferences
		return 0

	func get_theme() -> Theme:
		# Returns the current theme
		return Theme.new()

	func set_theme(idx: int) -> bool:
		# Sets a theme located at a given "idx" in preferences
		# If theme set successfully then return true, else false
		return false

	func remove_theme(theme: Theme) -> void:
		# Remove a theme from preferences
		pass


class ToolAPI:
	# Tool methods
	func add_tool(
		tool_name: String,
		display_name: String,
		shortcut: String,
		scene: PackedScene,
		extra_hint := "",
		extra_shortucts := [],
		layer_types: PoolIntArray = []
	) -> void:
		# Adds a tool with the above detail
		pass

	func remove_tool(tool_name: String) -> void:
		# Removes a tool with name "tool_name"
		# and assign Pencil as left tool, Eraser as right tool
		pass


class SelectionAPI:
	func clear_selection() -> void:
		pass

	func select_all() -> void:
		pass

	func select_rect(select_rect: Rect2, operation := 0) -> void:
		# 0 for adding, 1 for subtracting, 2 for intersection
		pass

	func move_selection(destination: Vector2, with_content := true, transform_standby := false):
		# (transform_standby = true) then the transformation will not be applied immediately
		# unless "Enter" is pressed
		pass

	func resize_selection(new_size: Vector2, with_content := true, transform_standby := false):
		# (transform_standby = true) then the transformation will not be applied immediately
		# unless "Enter" is pressed
		pass

	func invert() -> void:
		pass

	func make_brush() -> void:
		pass

	func copy() -> void:
		pass

	func paste(in_place := false) -> void:
		pass

	func delete_content() -> void:
		pass


class ProjectAPI:
	func new_project(
		frames := [],
		name := tr("untitled"),
		size := Vector2(64, 64),
		fill_color := Color.transparent
	) -> Project:
		# Will Create a new project (as tab) based on the given data
		# and also return itself
		return null

	func switch_to(project: Project):
		# Switches to the tab that contains the "project"
		pass

	func get_current_project() -> Project:
		# Returns the current project (type: Project)
		return null

	func get_project_info(project) -> Dictionary:
		# Returns dictionary containing all the project information
		return {}

	func get_current_cel() -> BaseCel:
		# returns the current cel
		# cel type can be checked using method (get_class_name)
		# type can be "GroupCel", "PixelCel", "Cel3D", and "BaseCel"
		return null

	func get_cel_at(project, frame: int, layer: int) -> BaseCel:
		# frames from left to right, layers from bottom to top
		# frames/layers start at "0"
		# and end at (project.frames.size() - 1) and (project.layers.size() - 1) respectively
		return null

	func set_pixelcel_image(image: Image, frame: int, layer: int):
		# target project will be the current project
		# frames from left to right, layers from bottom to top
		pass

	func add_new_frame(after_frame: int):
		# Adds a new frame in the "current project"
		pass

	func add_new_layer(above_layer: int, name := "", type := 0):
		# Adds a new Layer in the "current project"

		# type = 0 --> PixelLayer, type = 1 --> GroupLayer, type = 2 --> 3DLayer
		# above_layer = 0 is the bottom-most layer and so on
		pass


class ExportAPI:
	enum ExportTab { IMAGE = 0, SPRITESHEET = 1}

	func add_export_option(
		format_info: Dictionary, exporter_generator, tab := ExportTab.IMAGE, is_animated := true
	) -> int:
		# PARAMETERS:
		# format_info has keys "extension" and "description" whose values are of type String
		# FOR EXAMPLE
			# format_info = {"extension": ".gif", "description": "GIF Image"}

		# exporter_generator is the node containing a script which has method (override_export)
		# which has 1 argument of type Dictionary which has keys
		# "processed_images", "durations", "export_dialog", "export_paths", "project"

		# if the value of tab is not in ExportTab then the format will be added to both

		# returns the index of exporter. use this in (remove_export_option)
		return 0

	func remove_export_option(id: int):
		# Removes the exporter from Pixelorama
		pass


class SignalsAPI:
	# Global signals
	func connect_project_changed(target: Object, method: String):
		return

	func disconnect_project_changed(target: Object, method: String):
		return

	func connect_cel_changed(target: Object, method: String):
		return

	func disconnect_cel_changed(target: Object, method: String):
		return

	# Tool Signal
	func connect_tool_color_changed(target: Object, method: String):
		return

	func disconnect_tool_color_changed(target: Object, method: String):
		return

	# updater signals
	func connect_current_cel_texture_changed(target: Object, method: String):
		return

	func disconnect_current_cel_texture_changed(target: Object, method: String):
		return
