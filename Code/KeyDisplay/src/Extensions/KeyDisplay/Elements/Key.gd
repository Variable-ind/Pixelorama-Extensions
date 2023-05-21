extends PanelContainer

var text = ""

func _ready() -> void:
	set_text()


func set_text():
	$Text.text = text
