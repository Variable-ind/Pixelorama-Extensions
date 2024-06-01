extends Window


func _on_Create_pressed() -> void:
	$NewExtension.popup_centered()


func _on_Copy_pressed() -> void:
	DisplayServer.clipboard_set($PanelContainer/Content/VBoxContainer/HBoxContainer/Code.text)


func _on_close_requested() -> void:
	hide()
