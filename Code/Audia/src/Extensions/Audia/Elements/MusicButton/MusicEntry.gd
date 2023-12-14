extends PanelContainer

var _path: String

onready var path_label: Label = $"%Path"
onready var identifier_label: LineEdit = $"%Identifier"

var old_p_size := Vector2.ZERO
var Audioloader = load("res://src/Extensions/Audia/Elements/3rd party/GDScriptAudioImport.gd")
var reference_data: Dictionary  # only used to see which is which
var audio_stream: AudioStream


func _ready() -> void:
	ExtensionsApi.signals.connect_cel_changed(self, "check_if_timeline_refreshed")


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
	_update_tag(identifier_label.text)


func prepare_stream():
	var new_loader = Audioloader.new()
	audio_stream = new_loader.loadfile(_path)


func _on_Identifier_text_changed(new_text: String) -> void:
	var project: Project = ExtensionsApi.project.get_current_project()
	var data: Array = project.get_meta("Music", [])
	data.erase(reference_data)
	_update_tag(reference_data["identifier"])
	reference_data = serialize()
	data.append(reference_data)


func _on_Close_pressed() -> void:
	var project: Project = ExtensionsApi.project.get_current_project()
	var data: Array = project.get_meta("Music", [])
	data.erase(reference_data)
	queue_free()


func _update_tag(old_name: String ,full_refresh := true):
	var tag_container = ExtensionsApi.general.get_global().tag_container
	for child in tag_container.get_children():
		if child.tag.name == old_name:
			var indicator = child.get_node_or_null("AudioIndicator")
			if indicator:
				indicator.queue_free()
		if full_refresh:
			if child.tag.name == identifier_label.text:
				var indicator = ColorRect.new()
				indicator.rect_min_size.y = 5
				indicator.name = "AudioIndicator"
				indicator.color = child.tag.color
				child.add_child(indicator)


func check_if_timeline_refreshed():
	var project = ExtensionsApi.project.get_current_project()
	var new_size = Vector2(project.frames.size(), project.layers.size())
	if old_p_size != new_size:
		old_p_size = new_size
		yield(get_tree(), "idle_frame")
		refresh_self()


func refresh_self():
	_update_tag(identifier_label.text)


func _exit_tree() -> void:
	_update_tag(identifier_label.text, false)
