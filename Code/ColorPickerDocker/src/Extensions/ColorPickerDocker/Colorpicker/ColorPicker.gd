extends ColorPicker

enum Mode { LEFT, RIGHT }

var _presets := PoolColorArray()
var _mode = Mode.LEFT
var _color_picking := false
var _color_pickers: Node
var _new_eyedrop := ToolButton.new()
var _tool_color_slot: ColorPickerButton
var _value_sliders: Array
var _preset_panel: GridContainer
var _second_palette: HFlowContainer

onready var items_holder = get_child(2)


func _ready() -> void:
	_modifiy_colorpicker()
	_color_pickers = ExtensionsApi.general.get_global().control.find_node("Color Pickers")
	change_tool_slot(Mode.LEFT)

	# in case extension starts with pixelorama
	yield(get_tree(), "idle_frame")
	color = _tool_color_slot.color


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if _color_picking:
			color = _pick_color(ExtensionsApi.general.get_canvas().current_pixel, color)
	if event is InputEventMouseButton:
		if _color_picking:
			ExtensionsApi.general.get_global().can_draw = false
			ExtensionsApi.general.get_global().has_focus = false
			_color_picking = false
			_new_eyedrop.pressed = false
			yield(get_tree(), "idle_frame")
			ExtensionsApi.general.get_global().can_draw = true
			ExtensionsApi.general.get_global().has_focus = true
		else:
			if color != _tool_color_slot.color:
				color = _tool_color_slot.color


func _exit_tree() -> void:
	# remove any presets in-case the extension is reloading
	disconnect("preset_removed", self, "_on_ColorPicker_preset_removed")
	ExtensionsApi.panel.remove_node_from_tab(_second_palette)
	_second_palette.queue_free()


## Helper Functions
func change_tool_slot(index: int):
	if !_color_pickers:
		return
	if _tool_color_slot:
		_tool_color_slot.disconnect("color_changed", self, "_tool_color_changed")
	match index:
		Mode.LEFT:
			_tool_color_slot = _color_pickers.left_picker
		Mode.RIGHT:
			_tool_color_slot = _color_pickers.right_picker
	color = _tool_color_slot.color
# warning-ignore:return_value_discarded
	_tool_color_slot.connect("color_changed", self, "_tool_color_changed")


func _pick_color(position: Vector2, default: Color) -> Color:
	# this is the came as colorpicker tool of pixelorama
	position = Vector2(int(position.x), int(position.y))
	var eye_color := Color(0, 0, 0, 0)
	var project: Project = ExtensionsApi.project.get_current_project()
	position = project.tiles.get_canon_position(position)
	position = Vector2(int(position.x), int(position.y))
	if position.x < 0 or position.y < 0:
		return default
	var image := Image.new()
	image.copy_from(project.get_current_cel().get_image())
	if position.x > image.get_width() - 1 or position.y > image.get_height() - 1:
		return default
	var curr_frame: Frame = project.frames[project.current_frame]
	for layer in project.layers.size():
		var idx = (project.layers.size() - 1) - layer
		if project.layers[idx].is_visible_in_hierarchy():
			image = curr_frame.cels[idx].get_image()
			image.lock()
			eye_color = image.get_pixelv(position)
			image.unlock()
			if eye_color != Color(0, 0, 0, 0):
				break
	return eye_color


func _modifiy_colorpicker():
	# some initial setup
	get_child(0).get_child(0).rect_min_size = Vector2.ZERO
	get_child(0).get_child(0).size_flags_vertical = SIZE_FILL
	get_child(3).visible = false
	get_child(5).visible = false
	var add_preset_b: BaseButton = get_child(6).get_child(0)
# warning-ignore:return_value_discarded
	add_preset_b.connect(
		"button_up", self, "_on_recalculate_preset_min_size", [add_preset_b, add_preset_b.rect_size]
	)
# warning-ignore:return_value_discarded
	connect(
		"resized", self, "_on_recalculate_preset_min_size", [add_preset_b, add_preset_b.rect_size]
	)

	# make custom eyedrop
	var old_eyedrop_button: ToolButton = get_child(1).get_child(1)
	_new_eyedrop.toggle_mode = true
	_new_eyedrop.icon = old_eyedrop_button.icon
	_new_eyedrop.rect_min_size = old_eyedrop_button.rect_min_size
	old_eyedrop_button.get_parent().add_child(_new_eyedrop)
# warning-ignore:return_value_discarded
	_new_eyedrop.connect("toggled", self, "_on_activate_eyedrop")
	old_eyedrop_button.visible = false
# warning-ignore:return_value_discarded
	connect("color_changed", self, "_on_ColorPicker_color_changed")

	# add an option button
	var option = OptionButton.new()
	option.add_item("Left Tool")
	option.add_item("Right Tool")
	option.size_flags_horizontal = SIZE_EXPAND_FILL
	option.connect("item_selected", self, "_on_TargetColorPicker_changed")
	var label = Label.new()
	label.text = "Change Color of: "
	label.size_flags_horizontal = SIZE_EXPAND_FILL
	var container = HBoxContainer.new()
	container.add_child(label)
	container.add_child(option)
	items_holder.add_child(container)

	# track items that can be hidden
	_value_sliders.append(get_child(4).get_child(0))
	_value_sliders.append(get_child(4).get_child(1))
	_value_sliders.append(get_child(4).get_child(2))
	_value_sliders.append(get_child(4).get_child(3))
	_value_sliders.append(get_child(4).get_child(4).get_child(0))
	_value_sliders.append(get_child(4).get_child(4).get_child(1))
	var check_box = CheckBox.new()
	check_box.text = "Hide Sliders"
	check_box.connect("toggled", self, "_on_toggle_sliders_visibility")
	items_holder.add_child(check_box)
	var visible_state = ExtensionsApi.general.get_config_file().get_value(
		"ColorPickerDocker", "_hide_sliders", false
	)
	check_box.pressed = visible_state

	# Detach preset buttons
	_preset_panel = add_preset_b.get_parent()
	_preset_panel.visible = false
	_preset_panel.remove_child(add_preset_b)
	for child in _preset_panel.get_children():
		child.queue_free()
	_presets = ExtensionsApi.general.get_config_file().get_value(
		"ColorPickerDocker", "_preset_colors", _presets
	)
	for preset in _presets:
		add_preset(preset)
	_second_palette = HFlowContainer.new()
	_second_palette.name = "ColorPicker Palette"
	_second_palette.add_child(add_preset_b)
	ExtensionsApi.panel.add_node_as_tab(_second_palette)


## Signals
func _on_ColorPicker_preset_added(color: Color) -> void:
	if !color in _presets:
		_presets.append(color)
		ExtensionsApi.general.get_config_file().set_value(
			"ColorPickerDocker", "_preset_colors", _presets
		)


func _on_ColorPicker_preset_removed(color: Color) -> void:
	var idx = _presets.find(color)
	if idx != -1:
		_second_palette.get_child(idx).queue_free()
		_presets.remove(idx)
		ExtensionsApi.general.get_config_file().set_value(
			"ColorPickerDocker", "_preset_colors", _presets
		)


func _on_ColorPicker_color_changed(new_color: Color) -> void:
	if _tool_color_slot:
		_tool_color_slot.color = new_color
		_tool_color_slot.emit_signal("color_changed", new_color)


func _on_activate_eyedrop(pressed: bool):
	_color_picking = pressed
	if _color_picking:
		if !is_connected("color_changed", self, "_on_ColorPicker_color_changed"):
# warning-ignore:return_value_discarded
			connect("color_changed", self, "_on_ColorPicker_color_changed")
	else:
		if is_connected("color_changed", self, "_on_ColorPicker_color_changed"):
			disconnect("color_changed", self, "_on_ColorPicker_color_changed")


func _on_toggle_sliders_visibility(pressed: bool):
	ExtensionsApi.general.get_config_file().set_value("ColorPickerDocker", "_hide_sliders", pressed)
	for item in _value_sliders:
		item.visible = !pressed


func _on_TargetColorPicker_changed(index: int):
	_mode = index
	change_tool_slot(index)


func _tool_color_changed(new_color: Color):
	color = new_color


func _on_recalculate_preset_min_size(adder_button: BaseButton, new_size: Vector2):
	adder_button.get_parent().remove_child(adder_button)
	# move added presets to flow container
	for child in _preset_panel.get_children():
		child.add_to_group("presets")
		_preset_panel.remove_child(child)
		_second_palette.add_child(child)

	_second_palette.add_child(adder_button)
	for child in _second_palette.get_children():
		child.rect_min_size = new_size
