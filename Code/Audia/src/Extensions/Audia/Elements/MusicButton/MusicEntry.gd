extends PanelContainer

var _path: String

@onready var path_label: Label = $"%Path3D"
@onready var identifier_label: LineEdit = $"%Identifier"

var old_p_size := Vector2.ZERO
var Audioloader = load("res://src/Extensions/Audia/Elements/3rd party/GDScriptAudioImport.gd")
var reference_data: Dictionary  # only used to see which is which
var audio_stream: AudioStream


func _ready() -> void:
	ExtensionsApi.signals.signal_cel_switched(check_if_timeline_refreshed)


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
		path_label.tooltip_text = _path
		var new_loader = Audioloader.new()
		audio_stream = new_loader.loadfile(_path)
		if !FileAccess.file_exists(_path):
			path_label.self_modulate = Color.ORANGE_RED
	if data.has("identifier"):
		identifier_label.text = data["identifier"]
	reference_data = data
	_update_tag(identifier_label.text)


func prepare_stream():
	var new_loader = Audioloader.new()
	audio_stream = new_loader.loadfile(_path)


func _on_Identifier_text_changed(_new_text: String) -> void:
	var project: Project = ExtensionsApi.project.current_project
	var data: Array = project.get_meta("Music", [])
	data.erase(reference_data)
	_update_tag(reference_data["identifier"])
	reference_data = serialize()
	data.append(reference_data)


func _on_Close_pressed() -> void:
	var project: Project = ExtensionsApi.project.current_project
	var data: Array = project.get_meta("Music", [])
	data.erase(reference_data)
	queue_free()


func _update_tag(old_name: String ,full_refresh := true):
	var tag_container = ExtensionsApi.general.get_global().tag_container
	for child: Control in tag_container.get_children():
		if child.tag.name == old_name:
			for element in child.get_children():
				if element.is_in_group("AudioIndicator"):
					element.queue_free()
		if full_refresh:
			if child.tag.name == identifier_label.text:
				var new_indicator := TextureRect.new()
				child.add_child(new_indicator)
				new_indicator.add_to_group("AudioIndicator")
				new_indicator.modulate = child.tag.color
				new_indicator.texture = preload("res://src/Extensions/Audia/music_icon.png")
				new_indicator.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
				new_indicator.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
				new_indicator.size = Vector2.ONE * child.size.y / 1.5


func check_if_timeline_refreshed():
	var project = ExtensionsApi.project.current_project
	var new_size = Vector2(project.frames.size(), project.layers.size())
	if old_p_size != new_size:
		old_p_size = new_size
		await get_tree().process_frame
		refresh_self()


func refresh_self():
	_update_tag(identifier_label.text)


func _exit_tree() -> void:
	_update_tag(identifier_label.text, false)
	ExtensionsApi.signals.signal_cel_switched(check_if_timeline_refreshed, true)
