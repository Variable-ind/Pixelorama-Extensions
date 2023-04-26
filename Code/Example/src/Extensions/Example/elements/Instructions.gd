extends WindowDialog


func _on_Creator_pressed() -> void:
	self.popup_centered()


func _on_Create_pressed() -> void:
	$NewExtension.popup_centered()


func _on_Copy_pressed() -> void:
	OS.clipboard = $PanelContainer/Content/VBoxContainer/HBoxContainer/Code.text
