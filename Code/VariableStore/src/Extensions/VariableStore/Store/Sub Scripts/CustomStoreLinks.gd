extends VBoxContainer

var global: Node
var custom_links: Array = []


func _ready() -> void:
	global = get_node_or_null("/root/Global")
	if global:
		custom_links = global.config_cache.get_value("VariableStore", "custom_links", [])
	for link in custom_links:
		add_field(link)


func update_links() -> void:
	custom_links.clear()
	for child in $Links.get_children():
		if child.text != "":
			custom_links.append(child.text)
	if global:
		global.config_cache.set_value("VariableStore", "custom_links", custom_links)


func _on_NewLink_pressed() -> void:
	add_field()


func add_field(link: String = "") -> void:
	var link_field = LineEdit.new()
	link_field.placeholder_text = "Leave it empty and it will automatically remove itself on restart"
	link_field.text = link
	$Links.add_child(link_field)
	link_field.connect("text_changed", self, "field_text_changed")


func field_text_changed(_text: String) -> void:
	update_links()


func _on_Options_visibility_changed() -> void:
	for child in $Links.get_children():
		if child.text == "":
			child.queue_free()


func _on_Guide_pressed() -> void:
	OS.shell_open("https://github.com/Variable-Interactive/Variable-Store/tree/master#rules-for-writing-a-store_info-file")
