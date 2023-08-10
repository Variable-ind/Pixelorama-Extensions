extends Node

var camera_preview: Camera2D
var slider_a: Range
var slider_old: VSlider

# This script acts as a setup for the extension
func _enter_tree() -> void:
	camera_preview = ExtensionsApi.general.get_global().camera_preview
	var container: VBoxContainer = ExtensionsApi.general.get_global().canvas_preview_container.get_child(0)
	slider_a = load("res://src/UI/Nodes/ValueSlider.tscn").instance()
	container.add_child(slider_a)
	slider_a.allow_greater = true
	slider_a.min_value = (100.0)/camera_preview.zoom_max.x
	slider_a.max_value = (100.0)/camera_preview.zoom_min.x
	slider_a.value = (100.0)/camera_preview.zoom.x
	slider_a.prefix = "zoom"
	slider_a.suffix = "%"
	slider_old = container.find_node("PreviewZoomSlider")
	if slider_old:
		slider_old.get_parent().visible = false
	slider_a.get_parent().move_child(slider_a, 0)
	slider_a.connect("value_changed", self, "change_zoom")
	camera_preview.connect("zoom_changed", self, "_zoom_changed")


func change_zoom(value: float) -> void:  # Extension is being uninstalled or disabled
	var ratio: float = 100.0 / value
	camera_preview.zoom = Vector2(ratio, ratio)


func _zoom_changed():
	slider_a.value = (100.0)/camera_preview.zoom.x


func _exit_tree() -> void:
	if slider_old:
		slider_old.get_parent().visible = true
	slider_a.queue_free()
