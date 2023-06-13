extends Node

var neon_silver = preload("res://src/Extensions/ThemePack/NeonSilver/theme.tres")
var neon_blue = preload("res://src/Extensions/ThemePack/NeonBlue/theme.tres")
var neon_pink = preload("res://src/Extensions/ThemePack/NeonPink/theme.tres")
var pixel_sprite = preload("res://src/Extensions/ThemePack/PixelSprite/theme.tres")
var current_theme

# This script acts as a setup for the extension
func _enter_tree() -> void:
	current_theme = ExtensionsApi.theme.get_theme()
	ExtensionsApi.theme.add_theme(neon_silver)
	ExtensionsApi.theme.add_theme(neon_blue)
	ExtensionsApi.theme.add_theme(neon_pink)
	ExtensionsApi.theme.add_theme(pixel_sprite)


func _exit_tree() -> void:
	ExtensionsApi.theme.remove_theme(neon_silver)
	ExtensionsApi.theme.remove_theme(neon_blue)
	ExtensionsApi.theme.remove_theme(neon_pink)
	ExtensionsApi.theme.remove_theme(pixel_sprite)
