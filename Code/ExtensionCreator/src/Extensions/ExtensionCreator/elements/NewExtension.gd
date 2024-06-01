extends ConfirmationDialog

var template := 0
var extension_json := {
	"name": "Example",
	"display_name": "Anything you want",
	"description": "What the Extension Does",
	"author": "Your Name",
	"version": "0.1",
	"supported_api_versions": [4],
	"license": "MIT",
	"nodes": [
		"Main.tscn"
	]
}
@onready var api_options: OptionButton = $VBoxContainer/PanelContainer/ExtensionJsonOptions/Api

func _ready() -> void:
	# api aptions along with their represented versions
	api_options.add_item("Pixelorama 1.0.x", 4)

	api_options.selected = api_options.get_item_count() - 1
	for button_idx in %TemplateList.get_child_count():
		var button: Button = %TemplateList.get_child(button_idx)
		button.pressed.connect(select_template.bind(button_idx))


func _on_NewExtension_about_to_show() -> void:
	%path.text = ProjectSettings.globalize_path("res://")


func _on_NewExtension_confirmed() -> void:
	var save_path = %path.text
	if save_path.ends_with("/"):
		save_path[-1] = ""
	save_path += str("/", extension_json.name, "/")

	var extension_path = str(save_path, "src/Extensions/", extension_json.name, "/")

	# Step 1 : create a base directory
	DirAccess.make_dir_recursive_absolute(extension_path)
	if DirAccess.get_open_error() != OK:
		$Error.popup_centered()
		return

	# Step 2 : make an extension.json
	var json_path = extension_path.path_join("extension.json")
	var file := FileAccess.open(json_path, FileAccess.WRITE)
	file.store_string(var_to_str(extension_json))
	file.close()

	# Step 2 : make the rest of the files
	var maker = load(
		("res://src/Extensions/ExtensionCreator/elements/APIs/%d/Maker.gd"
		) % extension_json["supported_api_versions"][0]
	)
	var api_err = maker.make(save_path, extension_json.name, template)
	if api_err != OK:
		$Error.popup_centered()


#  Parameters
func select_template(idx: int):
	template = idx
	for i in %TemplateList.get_child_count():
		%TemplateList.get_child(i).disabled = (i == idx)


func _on_Name_text_changed(new_text: String) -> void:
	if new_text == "":
		extension_json.name = %NameEdit.placeholder_text
	else:
		extension_json.name = new_text


func _on_DisplayName_text_changed(new_text: String) -> void:
	if new_text == "":
		extension_json.display_name = %DisplayNameEdit.placeholder_text
	else:
		extension_json.display_name = new_text


func _on_Description_text_changed(new_text: String) -> void:
	if new_text == "":
		extension_json.description = %DescriptionEdit.placeholder_text
	else:
		extension_json.description = new_text


func _on_Author_text_changed(new_text: String) -> void:
	if new_text == "":
		extension_json.author = %AuthorEdit.placeholder_text
	else:
		extension_json.author = new_text


func _on_Target_Api_selected(index: int) -> void:
	for button in %TemplateList.get_children():
		button.visible = true
	match index:
		0:
			extension_json["supported_api_versions"][0] = 3  # 0.11.x


func _on_Version_value_changed(value: float) -> void:
	extension_json.version = str(value)


func _on_License_text_changed(new_text: String) -> void:
	if new_text == "":
		extension_json.license = "MIT"
	else:
		extension_json.license = new_text


func _on_Choose_pressed() -> void:
	$FileDialog.popup_centered()
	$FileDialog.current_dir = %path.text


func _on_FileDialog_dir_selected(dir: String) -> void:
	%path.text = dir
