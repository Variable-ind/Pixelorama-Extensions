GDPC                                                                                       
   P   res://.godot/exported/133200997/export-b08e22479f832e7eb970079e0b023f65-Main.scn       Б      |§%G\Ћ”kwзHыФ    \   res://.godot/exported/133200997/export-b7dff1cd7747cd3cf786de59e14dc3a0-StatisticDialog.scn –      Ф
      -ІT•÷>”`ы.Ѓ    ,   res://.godot/global_script_class_cache.cfg  –*            N
=	€u1 BҐЪ$V'8       res://.godot/uid_cache.bin  р7      Н       Aіџ"уЗжxАьЕj+Qс       res://project.binaryА8      ы      РяьЄл+ЊЋ“ХШд:![    ,   res://src/Extensions/TimeTracking/Main.gd   Р      ;      JR•µ чµ’9MЫUЗC    4   res://src/Extensions/TimeTracking/Main.tscn.remap   р)      a       ∞дЭОЦS÷кЎ±–џKM    D   res://src/Extensions/TimeTracking/StatisticDialog/StatisticDialog.gdp      w      …†Уѕнч№joJЄћЮ    L   res://src/Extensions/TimeTracking/StatisticDialog/StatisticDialog.tscn.remap`*      l       ]F2НЫч'§iГ~З    0   res://src/Extensions/TimeTracking/extension.json        ш       +пI:смaVрQeћДїc        {
"author": "Variable",
"description": "tracks how much time has the project been active for",
"display_name": "Time Tracking",
"license": "MIT",
"name": "TimeTracking",
"nodes": [ "Main.tscn" ],
"supported_api_versions": [ 4 ],
"version": "0.2"
}
        RSRC                    PackedScene            €€€€€€€€                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script *   res://src/Extensions/TimeTracking/Main.gd €€€€€€€€      local://PackedScene_fbnnn !         PackedScene          	         names "         Main    script    Node    	   variants                       node_count             nodes     	   €€€€€€€€       €€€€                    conn_count              conns               node_paths              editable_instances              version             RSRC               extends Node

var item_id: int
var statistics_dialog: AcceptDialog

@onready var extension_api = get_node_or_null("/root/ExtensionsApi")

# This script acts as a setup for the extension
func _ready() -> void:
	var type = extension_api.menu.HELP
	statistics_dialog = preload(
		"res://src/Extensions/TimeTracking/StatisticDialog/StatisticDialog.tscn"
	).instantiate()
	extension_api.dialog.get_dialogs_parent_node().add_child(statistics_dialog)
	item_id = extension_api.menu.add_menu_item(type, "Project Statistics", statistics_dialog)


func _exit_tree() -> void:  # Extension is being uninstalled or disabled
	# remember to remove things that you added using this extension
	extension_api.menu.remove_menu_item(extension_api.menu.HELP, item_id)
	statistics_dialog.extension_about_to_shutdown()
	statistics_dialog.queue_free()
     RSRC                    PackedScene            €€€€€€€€                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script E   res://src/Extensions/TimeTracking/StatisticDialog/StatisticDialog.gd €€€€€€€€      local://PackedScene_o4upt <         PackedScene          	         names "   $      AcceptDialog 	   position    size    script    VBoxContainer    anchors_preset    anchor_right    anchor_bottom    offset_left    offset_top    offset_right    offset_bottom    File    layout_mode    HBoxContainer    Label    theme_type_variation    text    HSeparator    size_flags_horizontal    GridContainer    columns    Name    unique_name_in_owner 	   editable 	   LineEdit    Label2 
   DirAccess    Total 
   TimeTotal    Changes    Label3    Saves    Label4    Sesions    Timer    	   variants       -       $   -   §  G                       А?      A      Ѕ     D¬      ,      HeaderSmall       Project Info:             Name:             dummy text              DirAccess:    #   Project is not saved anywhere yet.       Project Statistics:       Time:    	   Changes:       Saves:    	   Sesions:       node_count             nodes     ;  €€€€€€€€        €€€€                                        €€€€                           	      
                             €€€€                          €€€€                          €€€€            	      
                    €€€€                                €€€€                                €€€€                                €€€€                                                  €€€€                                €€€€                                                  €€€€                          €€€€                          €€€€            	                          €€€€                                €€€€                                €€€€                                €€€€                                                  €€€€                                €€€€                                                  €€€€                                 €€€€                                               !   €€€€                             "   €€€€                                             #   #   €€€€              conn_count              conns               node_paths              editable_instances              version             RSRC            extends AcceptDialog

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
         [remap]

path="res://.godot/exported/133200997/export-b08e22479f832e7eb970079e0b023f65-Main.scn"
               [remap]

path="res://.godot/exported/133200997/export-b7dff1cd7747cd3cf786de59e14dc3a0-StatisticDialog.scn"
    list=Array[Dictionary]([{
"base": &"RefCounted",
"class": &"AnimationTag",
"icon": "",
"language": &"GDScript",
"path": "res://src/Extensions/TimeTracking/EmptyClasses/AnimationTag.gd"
}, {
"base": &"RefCounted",
"class": &"BaseCel",
"icon": "",
"language": &"GDScript",
"path": "res://src/Extensions/TimeTracking/EmptyClasses/BaseCel.gd"
}, {
"base": &"RefCounted",
"class": &"BaseLayer",
"icon": "",
"language": &"GDScript",
"path": "res://src/Extensions/TimeTracking/EmptyClasses/BaseLayer.gd"
}, {
"base": &"VBoxContainer",
"class": &"BaseTool",
"icon": "",
"language": &"GDScript",
"path": "res://src/Extensions/TimeTracking/EmptyClasses/BaseTool.gd"
}, {
"base": &"BaseCel",
"class": &"Cel3D",
"icon": "",
"language": &"GDScript",
"path": "res://src/Extensions/TimeTracking/EmptyClasses/Cel3D.gd"
}, {
"base": &"Node3D",
"class": &"Cel3DObject",
"icon": "",
"language": &"GDScript",
"path": "res://src/Extensions/TimeTracking/EmptyClasses/Cel3DObject.gd"
}, {
"base": &"RefCounted",
"class": &"Drawer",
"icon": "",
"language": &"GDScript",
"path": "res://src/Extensions/TimeTracking/EmptyClasses/Drawers.gd"
}, {
"base": &"RefCounted",
"class": &"Frame",
"icon": "",
"language": &"GDScript",
"path": "res://src/Extensions/TimeTracking/EmptyClasses/Frame.gd"
}, {
"base": &"RefCounted",
"class": &"GIFAnimationExporter",
"icon": "",
"language": &"GDScript",
"path": "res://src/Extensions/TimeTracking/EmptyClasses/GIFAnimationExporter.gd"
}, {
"base": &"BaseCel",
"class": &"GroupCel",
"icon": "",
"language": &"GDScript",
"path": "res://src/Extensions/TimeTracking/EmptyClasses/GroupCel.gd"
}, {
"base": &"BaseLayer",
"class": &"GroupLayer",
"icon": "",
"language": &"GDScript",
"path": "res://src/Extensions/TimeTracking/EmptyClasses/GroupLayer.gd"
}, {
"base": &"ConfirmationDialog",
"class": &"ImageEffect",
"icon": "",
"language": &"GDScript",
"path": "res://src/Extensions/TimeTracking/EmptyClasses/ImageEffect.gd"
}, {
"base": &"BaseLayer",
"class": &"Layer3D",
"icon": "",
"language": &"GDScript",
"path": "res://src/Extensions/TimeTracking/EmptyClasses/Layer3D.gd"
}, {
"base": &"RefCounted",
"class": &"ObjParse",
"icon": "",
"language": &"GDScript",
"path": "res://src/Extensions/TimeTracking/EmptyClasses/ObjParse.gd"
}, {
"base": &"BaseCel",
"class": &"PixelCel",
"icon": "",
"language": &"GDScript",
"path": "res://src/Extensions/TimeTracking/EmptyClasses/PixelCel.gd"
}, {
"base": &"BaseLayer",
"class": &"PixelLayer",
"icon": "",
"language": &"GDScript",
"path": "res://src/Extensions/TimeTracking/EmptyClasses/PixelLayer.gd"
}, {
"base": &"RefCounted",
"class": &"Project",
"icon": "",
"language": &"GDScript",
"path": "res://src/Extensions/TimeTracking/EmptyClasses/Project.gd"
}, {
"base": &"Image",
"class": &"SelectionMap",
"icon": "",
"language": &"GDScript",
"path": "res://src/Extensions/TimeTracking/EmptyClasses/SelectionMap.gd"
}, {
"base": &"BaseTool",
"class": &"SelectionTool",
"icon": "",
"language": &"GDScript",
"path": "res://src/Extensions/TimeTracking/EmptyClasses/SelectionTool.gd"
}, {
"base": &"RefCounted",
"class": &"ShaderImageEffect",
"icon": "",
"language": &"GDScript",
"path": "res://src/Extensions/TimeTracking/EmptyClasses/ShaderImageEffect.gd"
}, {
"base": &"RefCounted",
"class": &"Tiles",
"icon": "",
"language": &"GDScript",
"path": "res://src/Extensions/TimeTracking/EmptyClasses/Tiles.gd"
}])
           vГC»Ј`F   res://src/Extensions/TimeTracking/StatisticDialog/StatisticDialog.tscnDћLѓ%°o+   res://src/Extensions/TimeTracking/Main.tscn   ECFG      application/config/name         TimeTracking   application/config/description$         A pixelorama Extention (The    application/config/features   "         4.2 ]   application/ field are not related to extention system so they can be anything)run/main_scene4      +   res://src/Extensions/TimeTracking/Main.tscn )   physics/common/enable_pause_aware_picking         $   rendering/quality/driver/driver_name         GLES2   %   rendering/vram_compression/import_etc              