extends GridContainer

var main_canvas: Control

var key_array := PoolStringArray()

onready var history_container: VBoxContainer = $"%HistoryContainer"
onready var key_container: HBoxContainer = $"%KeyContainer"


func _ready() -> void:
	main_canvas = ExtensionsApi.general.get_global().control.find_node("Main Canvas")
# warning-ignore:return_value_discarded
	main_canvas.connect("item_rect_changed", self, "update_position")
# warning-ignore:return_value_discarded
	connect("item_rect_changed", self, "update_position")
	update_position()


func update_position():
	if main_canvas:
		rect_global_position = main_canvas.rect_global_position + main_canvas.rect_size - rect_size


func update_text():
	move_to_history()
	for text in key_array:
		var key = preload("res://src/Extensions/KeyDisplay/Elements/Key.tscn").instance()
		key.text = text
		key_container.add_child(key)


func move_to_history():
	var old_keys = HBoxContainer.new()
	var fade_time := 0.5
	if key_array.size() > key_container.get_child_count():
		fade_time = 0
	old_keys.alignment = BoxContainer.ALIGN_END
	old_keys.modulate = Color.gray
	history_container.add_child(old_keys)
	for key in key_container.get_children():
		key_container.remove_child(key)
		old_keys.add_child(key)

	var tween := get_tree().create_tween()
# warning-ignore:return_value_discarded
	tween.tween_property(old_keys, "modulate", Color.transparent, fade_time)
# warning-ignore:return_value_discarded
	tween.tween_callback(old_keys, "queue_free")


func _input(event: InputEvent) -> void:
	var mouse_buttons = $Mouse
	if event is InputEventKey:
		var key = OS.get_scancode_string(event.physical_scancode)
		if event.pressed:
			if !key_array.empty():
				if !key_array.has(key):
					key_array.append(key)
				else:
					return
			else:
				key_array = [key]
		else:
			key_array.remove(key_array.find(key))
		update_text()

	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == BUTTON_LEFT:
				mouse_buttons.get_node("Left").visible = true
			elif event.button_index == BUTTON_RIGHT:
				mouse_buttons.get_node("Right").visible = true
			elif event.button_index == BUTTON_MIDDLE:
				mouse_buttons.get_node("Middle").visible = true
		else:
			mouse_buttons.get_node("Left").visible = false
			mouse_buttons.get_node("Right").visible = false
			mouse_buttons.get_node("Middle").visible = false


func _exit_tree() -> void:
	main_canvas.disconnect("item_rect_changed", self, "update_position")
	queue_free()
