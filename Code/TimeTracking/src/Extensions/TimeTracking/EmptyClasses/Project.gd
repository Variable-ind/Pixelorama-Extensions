# gdlint: ignore=max-public-methods
class_name Project
extends RefCounted
# A class for project properties.

var name := ""
var size: Vector2
var undo_redo := UndoRedo.new()
var tiles: Tiles
var undos := 0  # The number of times we added undo properties
var can_undo = true
var fill_color := Color(0)
var has_changed := false
# frames and layers Arrays should generally only be modified directly when
# opening/creating a project. When modifying the current project, use
# the add/remove/move/swap_frames/layers methods
var frames := []  # Array of Frames (that contain Cels)
var layers := []  # Array of Layers
var current_frame := 0
var current_layer := 0
var selected_cels := [[0, 0]]  # Array of Arrays of 2 integers (frame & layer)

var animation_tags := []  # Array of AnimationTags
var guides := []  # Array of Guides
var brushes := []  # Array of Images
var reference_images := []  # Array of ReferenceImages
var vanishing_points := []  # Array of Vanishing Points
var fps := 6.0

var x_symmetry_point
var y_symmetry_point
var x_symmetry_axis
var y_symmetry_axis

var selection_map := SelectionMap.new()
# This is useful for when the selection is outside of the canvas boundaries,
# on the left and/or above (negative coords)
var selection_offset := Vector2.ZERO
var has_selection := false

# For every camera (currently there are 3)
var cameras_rotation := [0.0, 0.0, 0.0]  # Array of float
var cameras_zoom := [Vector2(0.15, 0.15), Vector2(0.15, 0.15), Vector2(0.15, 0.15)]
var cameras_offset := [Vector2.ZERO, Vector2.ZERO, Vector2.ZERO]
var cameras_zoom_max := [Vector2.ONE, Vector2.ONE, Vector2.ONE]

# Export directory path and export file name
var directory_path := ""
var file_name := "untitled"
var file_format: int
var was_exported := false
var export_overwrite := false

func _init(_frames := [], _name := tr("untitled"), _size := Vector2(64, 64)) -> void:
	pass
