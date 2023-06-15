extends VBoxContainer

var colorpicker: PanelContainer
var selected_cels_only = false
var similarity = 100


func replace() -> void:
	var project = ExtensionsApi.project.get_current_project()
	# Go through each of the frames and layers of the project
	var selected_cels: Array = project.selected_cels.duplicate(true)
	var current_frame = project.current_frame
	if selected_cels_only:
		for cel in selected_cels:
			replace_cel_image(project, cel[0], cel[1])
	else:
		for frame in project.frames.size():
			for layer in project.layers.size():
				replace_cel_image(project, frame, layer)

	project.selected_cels = selected_cels
	project.change_cel(current_frame, -1)


func replace_cel_image(project, frame, layer) -> void:
	# Set the new (image).
	# Note: The old_image should not be used directly because it messed with undo/redo
	var old_image = ExtensionsApi.project.get_cel_at(project, frame, layer).get_image()
	var image = Image.new()
	image.copy_from(old_image)

	# Set the options for the ColorReplace shaded (shader copied from pixelorama's bucket shader)
	var selection: Image
	var selection_tex := ImageTexture.new()
	if project.has_selection:
		selection = project.selection_map
	else:
		selection = Image.new()
		selection.create(project.size.x, project.size.y, false, Image.FORMAT_RGBA8)
		selection.fill(Color(1, 1, 1, 1))
	selection_tex.create_from_image(selection)
	var pattern_tex := ImageTexture.new()

	var params := {
		"size": project.size,
		"old_color": colorpicker.left_picker.color,  # Here is your old color
		"new_color": colorpicker.right_picker.color,  # Here is your new color
		"similarity_percent": similarity,
		"selection": selection_tex,
		"pattern": pattern_tex,
		"pattern_size": pattern_tex.get_size(),
		"pattern_uv_offset":
		Vector2.ONE / pattern_tex.get_size() * Vector2.ZERO,
		"has_pattern": false
	}
	# Now finally apply the colorreplace shader to the image
	var gen = ExtensionsApi.general.get_shader_image_effect()
	var color_replace_shader = preload("res://src/Extensions/Swappy/shader/ColorReplace.shader")
	gen.generate_image(image, color_replace_shader, params, project.size)
	if image.data["data"] != old_image.data["data"]:  # if something's been changed
		ExtensionsApi.project.set_pixelcel_image(image, frame, layer)


func _on_OpenOptions_pressed() -> void:
	$"%Options".popup(Rect2($Dialogs.rect_global_position, $"%Options".rect_size))


func _on_OptionButton_item_selected(index: int) -> void:
	if index == 0:
		selected_cels_only = false
	else:
		selected_cels_only = true


func _on_Similarity_value_changed(value: float) -> void:
	similarity = value
