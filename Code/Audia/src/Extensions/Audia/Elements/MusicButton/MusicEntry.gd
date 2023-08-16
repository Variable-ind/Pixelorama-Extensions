extends PanelContainer

var _path: String

onready var path_label: Label = $"%Path"
onready var identifier_label: LineEdit = $"%Identifier"

var Audioloader = load("res://src/Extensions/Audia/Elements/3rd party/GDScriptAudioImport.gd")
var reference_data: Dictionary  # only used to see which is which
var audio_stream: AudioStream

func serialize() -> Dictionary:
	var data = {
		"path": _path,
		"identifier": identifier_label.text,
	}
	return data


func deserialize(data: Dictionary) -> void:
	if data.has("path"):
		_path = data["path"]
		path_label.text = _path
		path_label.hint_tooltip = _path
		var new_loader = Audioloader.new()
		audio_stream = new_loader.loadfile(_path)
		var file_test = File.new()
		if !file_test.file_exists(_path):
			path_label.self_modulate = Color.orangered
	if data.has("identifier"):
		identifier_label.text = data["identifier"]
	reference_data = data


func prepare_stream():
	var new_loader = Audioloader.new()
	audio_stream = new_loader.loadfile(_path)


func _on_Identifier_text_changed(new_text: String) -> void:
	var project: Project = ExtensionsApi.project.get_current_project()
	var data: Array = project.get_meta("Music", [])
	data.erase(reference_data)
	reference_data = serialize()
	data.append(reference_data)


func _on_Close_pressed() -> void:
	var project: Project = ExtensionsApi.project.get_current_project()
	var data: Array = project.get_meta("Music", [])
	data.erase(reference_data)
	queue_free()
