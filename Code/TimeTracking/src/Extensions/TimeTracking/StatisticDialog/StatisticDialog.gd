extends AcceptDialog

@onready var extension_api = get_node_or_null("/root/ExtensionsApi")
@onready var timer: Timer = $Timer

@onready var p_name: LineEdit = %Name
@onready var directory: LineEdit = %DirAccess
@onready var time_total: LineEdit = %TimeTotal
@onready var changes_total: LineEdit = %Changes
@onready var saves_total: LineEdit = %Saves
@onready var sesions_total: LineEdit = %Sesions

var project_in_focus: Project:
	set(new_project):
		timer.stop()
		if project_in_focus:
			project_in_focus.undo_redo.version_changed.disconnect(project_changes_made)
		project_in_focus = new_project
		version_in_focus = project_in_focus.undo_redo.get_version()
		project_in_focus.undo_redo.version_changed.connect(project_changes_made)
		timer.start()


func _ready() -> void:
	# Signal to switch target project in case it is switched
	extension_api.signals.signal_project_switched(change_target)

	# signal to detect passage of time on current project
	timer.timeout.connect(increment_project_time)

	# signal to detect manual saves (through "save"). this is unrelated to "save as"
	var file_menu: PopupMenu = extension_api.general.get_global().top_menu_container.file_menu
	file_menu.id_pressed.connect(calculate_save)

	# signal to detect manual saves (through "file dialog")
	var save_dialog: FileDialog = extension_api.general.get_global().save_sprites_dialog
	save_dialog.file_selected.connect(calculate_save)
	change_target()


## function to update project_in_focus whenever project is changed
func change_target():
	project_in_focus = extension_api.project.current_project


## used internally by extension api
func menu_item_clicked():
	popup_centered()
	update_ui()


## called through extension's Main.gd just before extension shuts down
## used for disconnecting signals that were connected in _ready (and other places)
func extension_about_to_shutdown() -> void:
	# change detection signal
	project_in_focus.undo_redo.version_changed.disconnect(project_changes_made)

	# target switching signals
	extension_api.signals.signal_project_switched(change_target, true)

	# save detection signals ("Save" and "Save as" respectively)
	var file_menu: PopupMenu = extension_api.general.get_global().top_menu_container.file_menu
	file_menu.id_pressed.disconnect(calculate_save)
	var save_dialog: FileDialog = extension_api.general.get_global().save_sprites_dialog
	save_dialog.file_selected.disconnect(calculate_save)


## updates the UI (called only when UI is visible)
func update_ui():
	show_name_path()
	show_time_total()
	show_changes_total()
	show_saves_total()
	show_sessions_total()


# Stat display functions
## Relatively simple and straightfarward function. Just displays "name" and "path" of project.
func show_name_path():
	var p_info = extension_api.project.get_project_info(project_in_focus)
	p_name.text = p_info.export_file_name
	if p_info.save_path:
		directory.text = p_info.save_path


## Displays the total time spent on target project in humanized format.
func show_time_total():
	time_total.text = time_convert(project_in_focus.get_meta("total_time", 0))


## Just displays total changes.
func show_changes_total():
	changes_total.text = str(project_in_focus.get_meta("total_change", 0))


## Just displays total changes saves.
func show_saves_total():
	saves_total.text = str(project_in_focus.get_meta("total_saves", 0))


## Just displays total sessions used by the project.
func show_sessions_total():
	sesions_total.text = str(project_in_focus.get_meta("old_sessions_total", 0))


# Calculators:
## Called every second
func increment_project_time() -> void:
	var last_time_sec: int = project_in_focus.get_meta("total_time", 0)
	project_in_focus.set_meta("total_time", last_time_sec + 1)

	# also take this method as an opportunity to update the UI every second
	if visible:
		update_ui()


## Uses [member version_in_focus] as reference point and
## [code]project_in_focus.undo_redo.get_version()[/code] as end to determine if a change is
## "Done" or "Undone"
var version_in_focus: int
func project_changes_made() -> void:
	var _old_total_changes = project_in_focus.get_meta("total_change", 0)

	# if this is the first change in the project then take this opportunity to check if this
	# is a new session as well
	if version_in_focus == 1:
		check_new_session()

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
		if variant == 4:  # Save (not Save as)
			var opensave = get_node_or_null("/root/OpenSave")
			var path = opensave.current_save_paths[extension_api.general.get_global().current_project_index]

			# Furthermore only increment if this isn't the "First" save
			# (As the first save is always the "Save as")
			if path != "":
				# this is whenever a save occurs without using the file dialog
				project_in_focus.set_meta("total_saves", total_saves + 1)

	elif typeof(variant) == TYPE_STRING:  # Save as
		# this is whenever a save occurs using the file dialog
		project_in_focus.set_meta("total_saves", total_saves + 1)


## This is a bit tricky, this uses the pixelorama's process id the project was last opened on
## to the current process's id, if they are different then this is a new session
func check_new_session():
	var old_p_num = project_in_focus.get_meta("last_process_id", 0)
	var current_p_id = OS.get_process_id()
	if old_p_num != current_p_id:
		var old_sessions_total = project_in_focus.get_meta("old_sessions_total", 0)
		project_in_focus.set_meta("old_sessions_total", old_sessions_total + 1)
		project_in_focus.set_meta("last_process_id", current_p_id)


# Helper functions
func time_convert(time_in_sec: int):
	var seconds = time_in_sec % 60
# warning-ignore:integer_division
	var minutes = (time_in_sec / 60) % 60
# warning-ignore:integer_division
	var hours = time_in_sec / 3600

	#returns a string with the format "HH:MM:SS"
	return "%02d:%02d:%02d" % [hours, minutes, seconds]
