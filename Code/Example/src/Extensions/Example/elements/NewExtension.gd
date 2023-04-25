extends ConfirmationDialog


var extension_json := {
	"name": "Example",
	"display_name": "Anything you want",
	"description": "What the Extension Does",
	"author": "Your Name",
	"version": "0.1",
	"supported_api_versions": [3],
	"license": "MIT",
	"nodes": [
		"Main.tscn"
	]
}


func _on_NewExtension_about_to_show() -> void:
	$VBoxContainer/Save/path.text = ProjectSettings.globalize_path("res://")


func _on_Name_text_changed(new_text: String) -> void:
	if new_text == "":
		extension_json.name = $VBoxContainer/Name/LineEdit.placeholder_text
	else:
		extension_json.name = new_text


func _on_DisplayName_text_changed(new_text: String) -> void:
	if new_text == "":
		extension_json.display_name = $VBoxContainer/DisplayName/LineEdit.placeholder_text
	else:
		extension_json.display_name = new_text


func _on_Description_text_changed(new_text: String) -> void:
	if new_text == "":
		extension_json.description = $VBoxContainer/Description/LineEdit.placeholder_text
	else:
		extension_json.description = new_text


func _on_Author_text_changed(new_text: String) -> void:
	if new_text == "":
		extension_json.author = $VBoxContainer/Author/LineEdit.placeholder_text
	else:
		extension_json.author = new_text


func _on_Target_Api_selected(index: int) -> void:
	extension_json["supported_api_versions"][0] = index + 2


func _on_Version_value_changed(value: float) -> void:
	extension_json.version = value


func _on_License_text_changed(new_text: String) -> void:
	if new_text == "":
		extension_json.license = "MIT"
	else:
		extension_json.license = new_text


func _on_Choose_pressed() -> void:
	$FileDialog.popup()
	$FileDialog.current_dir = $VBoxContainer/Save/path.text


func _on_FileDialog_dir_selected(dir: String) -> void:
	$VBoxContainer/Save/path.text = dir


func _on_NewExtension_confirmed() -> void:
	var save_path = $VBoxContainer/Save/path.text
	if save_path.ends_with("/"):
		save_path[-1] = ""
	save_path += str("/", extension_json.name, "/")

	var extension_path = str(save_path, "src/Extensions/", extension_json.name, "/")

	# Step 1 : create a base directory
	var dir := Directory.new()
	var err = dir.make_dir_recursive(extension_path)
	if err != OK:
		$Error.popup_centered()
		return

	# Step 2 : make  an extension.json
	var file := File.new()
	var json_path = extension_path.plus_file("extension.json")
# warning-ignore:return_value_discarded
	file.open(json_path, File.WRITE)
	file.store_string(var2str(extension_json))
	file.close()

	#Step 3 : make relevant files
	var main_path = extension_path.plus_file("Main.tscn")
	var main_script_path = extension_path.plus_file("Main.gd")
	var extension_api_path = extension_path.plus_file("ExtensionsApi.gd")
# warning-ignore:return_value_discarded
	file.open(main_path, File.WRITE)
	file.store_string($Hidden/MainTscn.text % extension_json.name)
	file.close()
# warning-ignore:return_value_discarded
	file.open(main_script_path, File.WRITE)
	file.store_string($Hidden/MainGd.text)
	file.close()
# warning-ignore:return_value_discarded
	file.open(extension_api_path, File.WRITE)
	file.store_string($Hidden/ApiVersions.get_child($VBoxContainer/ApiLevel/Api.selected).text)
	file.close()
# warning-ignore:return_value_discarded
	file.open(save_path.plus_file("project.godot"), File.WRITE)
	file.store_string($Hidden/Project.text.replace("Example", extension_json.name))
	file.close()
# warning-ignore:return_value_discarded
	file.open(save_path.plus_file("export_presets.cfg"), File.WRITE)
	file.store_string($Hidden/ExportCfg.text.replace("Example", extension_json.name))
	file.close()
