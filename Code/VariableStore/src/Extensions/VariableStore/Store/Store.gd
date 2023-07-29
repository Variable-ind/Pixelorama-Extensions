extends WindowDialog

### Usage:
### Change the "EXTENSION_NAME" and "STORE_LINK" from the (Main.gd)
### Don't touch anything else

# Variables that are set automatically in Main.gd
var store_link :String
var store_name :String
var extension_container :VBoxContainer

# variables placed here due to their frequent use
var extension_path: String  # the base path where extensions will be stored (obtained from pixelorama)
var store_information_file :String  # contains information about extensions available for download
var custom_links_remaining: int  # remaining custom links to be processed
var redirects :Array
var faulty_custom_links: Array

# node references
onready var content: VBoxContainer = $"%Content"
onready var store_info_downloader = $StoreInformationDownloader


func _ready() -> void:
	# Basic setup
	$"%VariableStore".text = store_link
	store_information_file = str(store_name,".txt")
	window_title = str(store_name, " (", get_store_version_info(), ")")
	# Get the path that pixelorama uses to store extensions
	var global: Node = get_node_or_null("/root/Global")
	if global:
		if extension_container:
			extension_path = ProjectSettings.globalize_path(extension_container.EXTENSIONS_PATH)
			# tell the downloader where to download the store information
			store_info_downloader.download_file = extension_path.plus_file(store_information_file)


func _on_Store_about_to_show() -> void:
	# clear old tags
	$"%SearchManager".available_tags = PoolStringArray()
	for tag in $"%SearchManager".tag_list.get_children():
		tag.queue_free()
	#Clear old entries
	for entry in content.get_children():
		entry.queue_free()
	faulty_custom_links.clear()
	custom_links_remaining = $"%CustomStoreLinks".custom_links.size()
	fetch_info(store_link)


func fetch_info(link: String) -> void:
	if extension_path != "":  # Did everything went smoothly in _ready() function?
		# everything is ready, now request the store information
		# so that available extensions could be displayed
		var error = store_info_downloader.request(link)
		if error == OK:
			prepare_progress()
		else:
			printerr("Unable to Get info from remote repository...")
			error_getting_info()


# If downloading is completed
func _on_StoreInformation_request_completed(result: int, _response_code: int, _headers: PoolStringArray, _body: PoolByteArray) -> void:
	if result == HTTPRequest.RESULT_SUCCESS:
		# Hide the progress bar because it's no longer required

		var file = File.new()
		var _error = file.open(extension_path.plus_file(store_information_file), File.READ)
		var newest_version :float
		var current_store_version = get_store_version_info()
		var store_update_available := false

		while not file.eof_reached():
			var info = str2var(file.get_line())
			# THIS IS THE SYSTEM TO CHECK FOR STORE UPDATES
			if typeof(info) == TYPE_REAL:
				# check version
				newest_version = info
				if newest_version > current_store_version and !store_update_available:
					store_update_available = true
			elif typeof(info) == TYPE_ARRAY:
				if store_update_available:
					var label := Label.new()
					label.text = str("Version ", newest_version, " is Available")
					content.add_child(label)
					add_entry(info)  # Announce update (the first entry in list is always the store entry)
					break
				else:
					if info[0] != store_name:
						add_entry(info)
			elif typeof(info) == TYPE_STRING:  # redirect store_link detected
				var link: String = info.strip_edges()
				if !link.begins_with("#") and link != "":
					if !info in redirects:
						redirects.append(info)

		file.close()
		var dir := Directory.new()
		_error = dir.remove(extension_path.plus_file(store_information_file))
		close_progress()
	else:
		printerr("Unable to Get info from remote repository...")
		error_getting_info()


################# HELPER METHODS #################

# SIGNAL CONNECTED FROM StoreButton.tscn
func _on_StoreButton_pressed() -> void:
	popup_centered()


# FUNCTION RELATED TO ERROR DIALOG
func _on_CopyCommand_pressed():
	OS.clipboard = "sudo flatpak override com.orama_interactive.Pixelorama --share=network"


# FUNCTION RELATED TO ERROR DIALOG
func _on_ManualDownload_pressed():
	# warning-ignore:return_value_discarded
	OS.shell_open("https://variable-interactive.itch.io/pixelorama-extensions")


# ADDS A NEW EXTENSION ENTRY TO THE "content"
func add_entry(info: Array) -> void:
	var entry = load("res://src/Extensions/%s/Store/Entry/Entry.tscn" % store_name).instance()
	entry.connect("tags_detected", $"%SearchManager", "add_new_tags")
	entry.extension_container = extension_container
	content.add_child(entry)
	entry.set_info(info, extension_path)


# GETS CALLED WHEN DATA COULDN'T BE FETCHED FROM REMOTE REPOSITORY
func error_getting_info():
	# Shows a popup if error is from main link (i-e VariableStore)
	# Popups for errors in custom_links are handled in close_progress()
	if custom_links_remaining == $"%CustomStoreLinks".custom_links.size():
		$Error.popup_centered()
	else:
		faulty_custom_links.append($"%CustomStoreLinks".custom_links[custom_links_remaining])
	close_progress()


# RETURNS THE CURRENT STORE VERSION
func get_store_version_info() -> float:
	var store_config_file_path: String = "res://src/Extensions/%s/extension.json" % store_name
	var store_config_file := File.new()
	var err := store_config_file.open(store_config_file_path, File.READ)
	if err != OK:
		printerr("Error loading config file: ", err)
		store_config_file.close()
		return float(0)

	var info_json = parse_json(store_config_file.get_as_text())
	store_config_file.close()

	if !info_json:
		printerr("No JSON data found.")
		return float(0)

	if info_json.has("version"):
		var version = str2var(info_json["version"])
		if typeof(version) == TYPE_REAL:
			return version
		else:
			return version
	else:
		return float(0)


# PROGRESS BAR METHOD
func prepare_progress():
	$ProgressPanel.visible = true
	$ProgressPanel/VBoxContainer/ProgressBar.value = 0
	$ProgressPanel/UpdateTimer.start()


# PROGRESS BAR METHOD
func update_progress():
	var down = store_info_downloader.get_downloaded_bytes()
	var total = store_info_downloader.get_body_size()
	$ProgressPanel/VBoxContainer/ProgressBar.value = (float(down) / float(total)) * 100.0


func close_progress():
	$ProgressPanel.visible = false
	$ProgressPanel/UpdateTimer.stop()
	if redirects.size() > 0:
		var next_link = redirects.pop_front()
		fetch_info(next_link)
	else:
		# no more redirects, jump to the next store
		custom_links_remaining -= 1
		if custom_links_remaining >= 0:
			var next_link = $"%CustomStoreLinks".custom_links[custom_links_remaining]
			fetch_info(next_link)
		else:
			if faulty_custom_links.size() > 0:  # manage custom faulty links
				$"%FaultyLinks".text = ""
				for link in faulty_custom_links:
					$"%FaultyLinks".text += str(link, "\n")
				$ErrorCustom.popup_centered()



# PROGRESS BAR METHOD
func _on_UpdateTimer_timeout():
	update_progress()
