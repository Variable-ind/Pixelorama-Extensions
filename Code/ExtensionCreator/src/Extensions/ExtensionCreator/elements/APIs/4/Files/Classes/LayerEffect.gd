class_name LayerEffect
extends RefCounted

var name := ""
var shader: Shader
var params := {}
var enabled := true


func _init(_name := "", _shader: Shader = null, _params := {}) -> void:
	return
