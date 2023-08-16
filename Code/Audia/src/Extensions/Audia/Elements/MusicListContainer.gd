extends PanelContainer


# references from pixelorama
var timer: Timer
var play_forward: BaseButton

var audio_tags: Dictionary
var stream_player = preload("res://src/Extensions/Audia/Elements/AudioManager/AudioController.tscn")
var current_playing_frame := -1
var is_playing := false
var streams_are_prepared := false

onready var option_button: OptionButton = $"%OptionButton"
onready var list: VBoxContainer = $"%List"
onready var audios: Node = $Audios


func _ready() -> void:
	# update the music library
	update_list()
	# Get references to widely used nodes
	timer = ExtensionsApi.general.get_global().animation_timer
	play_forward = ExtensionsApi.general.get_global().play_forward
	# signal connections
	ExtensionsApi.signals.connect_project_changed(self, "update_list")
	ExtensionsApi.signals.connect_cel_changed(self, "check_sanity")
	timer.connect("timeout", self, "manage_next_frame_music")
	play_forward.connect("toggled", self, "start_setup")
	get_tree().connect("files_dropped", self, "add_audios")
	# setup audio drivers list
	setup_audio_drivers()


func _exit_tree() -> void:
	# disconnect signals connected in this script
	ExtensionsApi.signals.disconnect_project_changed(self, "update_list")
	ExtensionsApi.signals.disconnect_cel_changed(self, "check_sanity")
	timer.disconnect("timeout", self, "manage_next_frame_music")
	play_forward.disconnect("toggled", self, "start_setup")
	get_tree().disconnect("files_dropped", self, "add_audios")


func add_audios(file_paths: PoolStringArray, _screen: int):
	var project: Project = ExtensionsApi.project.get_current_project()
	var data: Array = project.get_meta("Music", [])
	var valid_exts = ["mp3", "ogg", "wav"]
	var audio_added := false
	var old_paths := PoolStringArray()
	for entry in data:
		old_paths.append(entry["path"])
	for path in file_paths:
		if path.get_extension().to_lower() in valid_exts:
			audio_added = true
			ExtensionsApi.dialog.show_error("Added asuccessfully")
			if path in old_paths:
				continue
			var music_dict = {
				"path": path,
				"identifier": path.get_file().trim_suffix(str(".", path.get_extension())),
			}
			data.append(music_dict)
	if audio_added:
		project.set_meta("Music", data)
		update_list()


func update_list():
	var project: Project = ExtensionsApi.project.get_current_project()
	var data = project.get_meta("Music", [])
	for old_entry in list.get_children():
		old_entry.queue_free()
	for entry_data in data:
		var entry = preload("res://src/Extensions/Audia/Elements/MusicButton/MusicEntry.tscn").instance()
		list.add_child(entry)
		entry.deserialize(entry_data)


func start_setup(pressed: bool):
	audio_tags = {}
	if pressed:
		for music_entry in list.get_children():
			music_entry.prepare_stream()
			var data = music_entry.serialize()
			if !data["identifier"] in audio_tags.keys():
				audio_tags[data["identifier"]] = music_entry.audio_stream.duplicate()
	manage_start_stop(pressed)


# manages initial setup when farward play button is pressed
func manage_start_stop(pressed: bool):
	if !pressed:
		for player in audios.get_children():
			player.queue_free()
		current_playing_frame = -1
		is_playing = false
		return
	if is_playing:
		return
	is_playing = true

	var animation_tags: Array = ExtensionsApi.project.get_current_project().animation_tags
	var current_frame: int = ExtensionsApi.project.get_current_project().current_frame
	current_playing_frame = current_frame
	for tag in animation_tags:
		if current_frame + 1 >= tag.from && current_frame + 1 <= tag.to:
			if tag.name in audio_tags.keys():
				var new_stream_player = stream_player.instance()
				audios.add_child(new_stream_player)
				new_stream_player.start(current_frame, tag, audio_tags[tag.name])


# manages if a music should be played or not (i-e checks if we entered an audio tag)
func manage_next_frame_music():
	var animation_tags: Array = ExtensionsApi.project.get_current_project().animation_tags
	var current_frame: int = ExtensionsApi.project.get_current_project().current_frame
	for tag in animation_tags:
		if current_frame + 1 == tag.from:
			if tag.name in audio_tags.keys() and current_playing_frame != -1:
				var new_stream_player = stream_player.instance()
				audios.add_child(new_stream_player)
				new_stream_player.start(current_frame, tag, audio_tags[tag.name])
				is_playing = true
	if !is_playing and current_playing_frame != -1:
		manage_start_stop(true)
	current_playing_frame = current_frame


#  Detects if user clicked on another frame during playing
func check_sanity():
	var real_current_frame: int = ExtensionsApi.project.get_current_project().current_frame
	var expected_current_frame: int = current_playing_frame + 1
	if real_current_frame != expected_current_frame:
		manage_start_stop(false)
		if (
			real_current_frame > expected_current_frame
			and current_playing_frame != -1
		):
			manage_start_stop(true)


#  An Audio driver has been chosen
func _on_OptionButton_item_selected(index: int) -> void:
	ProjectSettings.set_initial_value("audio/driver", "Dummy")
	var driver_name = option_button.get_item_text(index)
	ProjectSettings.set_setting("audio/driver", driver_name)
	ProjectSettings.save_custom(ExtensionsApi.general.get_global().OVERRIDE_FILE)
	ExtensionsApi.dialog.show_error("Please restart to allow changes to take effect")


func setup_audio_drivers():
	var current_audio_driver = ProjectSettings.get_setting("audio/driver")
	var to_select: int
	for i in OS.get_audio_driver_count():
		var driver_name = OS.get_audio_driver_name(i)
		option_button.add_item(OS.get_audio_driver_name(i))
		if driver_name == current_audio_driver:
			to_select = i
	if to_select:
		option_button.select(to_select)
