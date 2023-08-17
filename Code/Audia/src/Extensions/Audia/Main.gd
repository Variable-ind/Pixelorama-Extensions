extends Node

# some references to nodes that will be created later
var panel: PanelContainer
var exporter_id: int

# This script acts as a setup for the extension
func _enter_tree() -> void:
	# add a test panel as a tab  (this is an example) the tab is located at the same
	# place as the (Tools tab) by default
	panel = preload("res://src/Extensions/Audia/Elements/MusicListContainer.tscn").instance()
	ExtensionsApi.panel.add_node_as_tab(panel)

	var info := {
		"extension": ".png",
		"description": "Shotcut"
	}
	exporter_id = ExtensionsApi.exports.add_export_option(info, self, 0, false)


func override_export(data: Dictionary):
	# set variables
	var dir_path: String
	var project = data["project"]
	var project_maker = load("res://src/Extensions/Audia/Classes/ShotcutMaker.gd").new()
	var dir := Directory.new()
	var moved_audios := []
	var p_size: Vector2

	# obtaining audios used in project
	var audio_tags := {}
	for child in panel.list.get_children():
		var dict = child.serialize()
		var tag = dict["identifier"]
		var path = dict["path"]
		if !tag in audio_tags.keys():
			audio_tags[tag] = path

	# save pngs
	for image_idx in data["processed_images"].size():
		var save_path = data["export_paths"][image_idx]
		var image: Image = data["processed_images"][image_idx]
		image.save_png(save_path)
		# set the dir path and project size (one time setup)
		if !dir_path:
			dir_path = save_path.replace(save_path.get_file(), "")
			p_size = image.get_size()

		# check if audio is to be played for this frame
		for tag in project.animation_tags:
			if tag.name in audio_tags.keys() and tag.from == image_idx + 1:  # Audio Detected
				var audio_path: String = audio_tags[tag.name]
				var new_name = str(tag.name, ".", audio_path.get_extension())
				var new_path: String = dir_path.plus_file(new_name)
				# calculate duration for audio
				var end_time := 0.0
				for frame_idx in range(tag.from - 1, tag.to):
					var frame: Frame = project.frames[frame_idx]
					var duration = frame.duration * (1.0 / project.fps)
					end_time += duration
				# if audio wasn't moved to aseet folder yet then move it there
				if !new_path in moved_audios:
					dir.copy(audio_path, new_path)
					moved_audios.append(new_path)
				project_maker.add_item_to_playlist(new_path, end_time)
		project_maker.add_item_to_playlist(data["export_paths"][image_idx], data["durations"][image_idx])
	# Now Compile all this information into a ShotCut project
	project_maker.compile(p_size)
	return true


func _exit_tree() -> void:  # Extension is being uninstalled or disabled
	# remember to remove things that you added using this extension
	ExtensionsApi.panel.remove_node_from_tab(panel)
	ExtensionsApi.exports.remove_export_option(exporter_id)
