extends ImageEffect

enum Animate { STRENGTH }
var shader: Shader = preload("res://src/Extensions/LineArt/Assets/LineArt.gdshader")

onready var strength_slider := $VBoxContainer/Options/Strength
onready var color_button := $VBoxContainer/Options/LineColor as ColorPickerButton


func _ready() -> void:
	var sm := ShaderMaterial.new()
	sm.shader = shader
	preview.set_material(sm)
	# set as in enum
	animate_panel.add_float_property("Strength", strength_slider)


func _about_to_show() -> void:
	_reset()
	._about_to_show()


func commit_action(cel: Image, project: Project = ExtensionsApi.general.get_global().current_project) -> void:
	var strength = animate_panel.get_animated_value(commit_idx, Animate.STRENGTH)
	var color = color_button.color
	var selection_tex := ImageTexture.new()
	if selection_checkbox.pressed and project.has_selection:
		selection_tex.create_from_image(project.selection_map, 0)

	var params := {"strength": strength, "color": color, "selection": selection_tex}
	if !confirmed:
		for param in params:
			preview.material.set_shader_param(param, params[param])
	else:
		var gen := ShaderImageEffect.new()
		gen.generate_image(cel, shader, params, project.size)
		yield(gen, "done")


func _reset() -> void:
	strength_slider.value = 0
	color_button.color = Color.black
	confirmed = false


func _on_LineColor_color_changed(_color: Color) -> void:
	update_preview()


func _on_Strength_value_changed(_value: float) -> void:
	update_preview()
