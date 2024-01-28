extends GridContainer

var main_canvas: Control

var key_array := PackedStringArray()

@onready var history_container: VBoxContainer = %HistoryContainer
@onready var key_container: HBoxContainer = %KeyContainer

var last_key_release_time: int

func _ready() -> void:
	var extensions_api = get_node_or_null("/root/ExtensionsApi")
	main_canvas = extensions_api.general.get_global().control.find_child("Main Canvas")
	main_canvas.item_rect_changed.connect(update_position)
	item_rect_changed.connect(update_position)
	update_position()


func update_position():
	if main_canvas:
		global_position = main_canvas.global_position + main_canvas.size - size


func update_text():
	move_to_history()
	for text in key_array:
		var key = preload("res://src/Extensions/KeyDisplay/Elements/Key.tscn").instantiate()
		key.text = text
		key_container.add_child(key)


func move_to_history():
	var old_keys = HBoxContainer.new()
	# determine a suitable fade time
	var fade_time := 0.5
	if key_array.size() > key_container.get_child_count():  # A new key was pressed
		fade_time = 0
	else:  # A key was released
		# if some keys were released very close together then ignore them
		if Time.get_ticks_msec() - last_key_release_time < 50:
			fade_time = 0
		last_key_release_time = Time.get_ticks_msec()

	for key in key_container.get_children():
		if key.text not in key_array:
			key.modulate = Color.YELLOW
		key_container.remove_child(key)
		old_keys.add_child(key)
	old_keys.alignment = BoxContainer.ALIGNMENT_END
	old_keys.modulate = Color.GRAY
	history_container.add_child(old_keys)

	var tween := get_tree().create_tween()
	tween.tween_property(old_keys, "modulate", Color.TRANSPARENT, fade_time)
	tween.tween_callback(old_keys.queue_free)


func _input(event: InputEvent) -> void:
	var mouse_buttons = $Mouse
	if event is InputEventKey:
		var key = OS.get_keycode_string(event.physical_keycode)
		if event.pressed:
			if !key_array.is_empty():
				if !key_array.has(key):
					key_array.append(key)
				else:
					return
			else:
				key_array = [key]
		else:
			key_array.remove_at(key_array.find(key))
		update_text()

	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == MOUSE_BUTTON_LEFT:
				mouse_buttons.get_node("Left").visible = true
			elif event.button_index == MOUSE_BUTTON_RIGHT:
				mouse_buttons.get_node("Right").visible = true
			elif event.button_index == MOUSE_BUTTON_MIDDLE:
				mouse_buttons.get_node("Middle").visible = true
		else:
			mouse_buttons.get_node("Left").visible = false
			mouse_buttons.get_node("Right").visible = false
			mouse_buttons.get_node("Middle").visible = false


func _exit_tree() -> void:
	main_canvas.item_rect_changed.disconnect(update_position)
	queue_free()
