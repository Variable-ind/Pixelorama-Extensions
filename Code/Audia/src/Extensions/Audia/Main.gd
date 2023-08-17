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
	var dir_path: String
	# "processed_images", "durations", "export_dialog", "export_paths", "project"
	var project_maker = load("res://src/Extensions/Audia/Classes/ShotcutMaker.gd").new()
	# save pngs
	for image_idx in data["processed_images"].size():
		var image: Image = data["processed_images"][image_idx]
		image.save_png(data["export_paths"][image_idx])
		if !dir_path:
			var path = data["export_paths"][image_idx]
			dir_path = path.replace(path.get_file(), "")
		project_maker.add_item_to_playlist(data["export_paths"][image_idx], data["durations"][image_idx])
	# add references to audios
	var audio_tags := {}
	for child in panel.list.get_children():
		var dict = child.serialize()
		var tag = dict["identifier"]
		var path = dict["path"]
		if !tag in audio_tags.keys():
			audio_tags[tag] = path
	if dir_path:
		var project = data["project"]
		var moved_audios := []
		var dir := Directory.new()
		for tag in project.animation_tags:
			if tag.name in audio_tags.keys():
				var audio_path: String = audio_tags[tag.name]
				var new_path: String = dir_path.plus_file(audio_path.get_file())
				# calculate duration
				var end_time := 0.0
				for frame_idx in range(tag.from - 1, tag.to):
					var frame: Frame = project.frames[frame_idx]
					var duration = frame.duration * (1.0 / project.fps)
					end_time += duration
				if !new_path in moved_audios:
					dir.copy(audio_path, new_path)
					moved_audios.append(new_path)
				project_maker.add_item_to_playlist(new_path, end_time)
	project_maker.compile()
	return true


func _exit_tree() -> void:  # Extension is being uninstalled or disabled
	# remember to remove things that you added using this extension
	ExtensionsApi.panel.remove_node_from_tab(panel)
	ExtensionsApi.exports.remove_export_option(exporter_id)
