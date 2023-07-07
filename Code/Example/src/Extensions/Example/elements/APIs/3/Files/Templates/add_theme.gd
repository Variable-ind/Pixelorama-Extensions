extends Node


var theme = load("res://Theme.tres") # Replace this with your theme resource
# your theme resource must be a derivative of themes from
# https://github.com/Orama-Interactive/Pixelorama/tree/master/assets/themes
# or else a CRASH might occur


# if a theme from the extension was set in preferences, then it will be automatically be
# set when pixelorama is launched again
func _enter_tree() -> void:
	if theme:
		ExtensionsApi.theme.add_theme(theme)  # Adds the theme to preferences


func _exit_tree() -> void:  # Extension is being uninstalled or disabled
	if theme:
		ExtensionsApi.theme.remove_theme(theme)  # Adds the theme to preferences
