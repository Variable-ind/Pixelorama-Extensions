extends AcceptDialog


onready var p_name: LineEdit = $"%Name"
onready var directory: LineEdit = $"%Directory"
onready var time_total: LineEdit = $"%TimeTotal"
onready var changes_total: LineEdit = $"%Changes"
onready var saves_total: LineEdit = $"%Saves"
onready var sesions_total: LineEdit = $"%Sesions"

#var _tabs = 0
var project_in_focus: Project


func _ready() -> void:
	ExtensionsApi.signals.connect_project_changed(self, "change_target")
	var file_menu = ExtensionsApi.general.get_global().top_menu_container.file_menu_button.get_popup()
	file_menu.connect("id_pressed", self, "calculate_save")
	var save_dialog: FileDialog = ExtensionsApi.general.get_global().save_sprites_dialog
# warning-ignore:return_value_discarded
	save_dialog.connect("file_selected", self, "calculate_save")
	change_target()


func menu_item_clicked():
	popup_centered()
	update_ui()


func prepare_exit_tree() -> void:
	ExtensionsApi.signals.disconnect_project_changed(self, "change_target")
	project_in_focus.undo_redo.disconnect("version_changed", self, "update_change")
	# to detect saves
	var file_menu = ExtensionsApi.general.get_global().top_menu_container.file_menu_button.get_popup()
	file_menu.disconnect("id_pressed", self, "calculate_save")
	var save_dialog: FileDialog = ExtensionsApi.general.get_global().save_sprites_dialog
	save_dialog.disconnect("file_selected", self, "calculate_save")


func update_ui():
	show_name_path()
	show_time_total()
	show_changes_total()
	show_saves_total()
	show_sessions_total()


# Stat display
func show_name_path():
	var p_info = ExtensionsApi.project.get_project_info(project_in_focus)
	p_name.text = p_info.export_file_name
	if p_info.save_path:
		directory.text = p_info.save_path


func show_time_total():
	time_total.text = time_convert(project_in_focus.get_meta("total_time", 0))


func show_changes_total():
	changes_total.text = str(project_in_focus.get_meta("total_change", 0))


func show_saves_total():
	saves_total.text = str(project_in_focus.get_meta("total_saves", 0))


func show_sessions_total():
	sesions_total.text = str(project_in_focus.get_meta("old_sessions_total", 0))


## Calculators:
# calculator of total time
func _on_SecondTimer_timeout() -> void:
	var last_time_sec: int = project_in_focus.get_meta("total_time", 0)
	project_in_focus.set_meta("total_time", last_time_sec + 1)
	if visible:
		update_ui()


# calculator of changes made
var version_in_focus: int
func update_change() -> void:
	var _old_total_changes = project_in_focus.get_meta("total_change", 0)
	if version_in_focus == 1:
		calculate_sessions_num()
	if project_in_focus.undo_redo.get_version() > version_in_focus:
		# change is done
		project_in_focus.set_meta("total_change", _old_total_changes + 1)
	else:
		# change is undone
		project_in_focus.set_meta("total_change", _old_total_changes - 1)
	version_in_focus = project_in_focus.undo_redo.get_version()


# calculator of save
func calculate_save(variant = null):
	var total_saves = project_in_focus.get_meta("total_saves", 0)
	if typeof(variant) == TYPE_INT:
		if variant == 4:
			var opensave = get_node_or_null("/root/OpenSave")
			var path = opensave.current_save_paths[ExtensionsApi.general.get_global().current_project_index]
			if path != "":
				# saves through file menu
				project_in_focus.set_meta("total_saves", total_saves + 1)
	elif typeof(variant) == TYPE_STRING:
		# saves through file dialog
		project_in_focus.set_meta("total_saves", total_saves + 1)


func calculate_sessions_num():
	var old_p_num = project_in_focus.get_meta("last_process_id", 0)
	var current_p_id = OS.get_process_id()
	if old_p_num != current_p_id:
		var old_sessions_total = project_in_focus.get_meta("old_sessions_total", 0)
		project_in_focus.set_meta("old_sessions_total", old_sessions_total + 1)
		project_in_focus.set_meta("last_process_id", current_p_id)


# Helper functions
func change_target():
	# it is supposed to change the timer to current project
	$SecondTimer.stop()
	project_in_focus = ExtensionsApi.project.get_current_project()
	version_in_focus = project_in_focus.undo_redo.get_version()
# warning-ignore:return_value_discarded
	project_in_focus.undo_redo.connect("version_changed", self, "update_change")
	$SecondTimer.start()


func time_convert(time_in_sec: int):
	var seconds = time_in_sec % 60
# warning-ignore:integer_division
	var minutes = (time_in_sec / 60) % 60
# warning-ignore:integer_division
	var hours = time_in_sec / 3600

	#returns a string with the format "HH:MM:SS"
	return "%02d:%02d:%02d" % [hours, minutes, seconds]
