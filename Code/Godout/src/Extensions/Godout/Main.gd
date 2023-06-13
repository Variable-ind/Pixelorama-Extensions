extends Node

# libraries for different OS all in their own array
var libraries := [
	"https://github.com/IsotoxalDev/Godout/raw/main/addons/godout/animation/gif/godout_gif_i686.dll",
	"https://github.com/IsotoxalDev/Godout/raw/main/addons/godout/animation/gif/godout_gif_x86_64.dll",
	"https://github.com/IsotoxalDev/Godout/raw/main/addons/godout/animation/gif/libgodout_gif_i686.so",
	"https://github.com/IsotoxalDev/Godout/raw/main/addons/godout/animation/gif/libgodout_gif_x86_64.so",

	"https://github.com/IsotoxalDev/Godout/raw/main/addons/godout/animation/webp/godout_webp_animation_i686.dll",
	"https://github.com/IsotoxalDev/Godout/raw/main/addons/godout/animation/webp/godout_webp_animation_x86_64.dll",
	"https://github.com/IsotoxalDev/Godout/raw/main/addons/godout/animation/webp/libgodout_webp_animation_i686.so",
	"https://github.com/IsotoxalDev/Godout/raw/main/addons/godout/animation/webp/libgodout_webp_animation_x86_64.so",
]

var current_download = 0
# some references to nodes that will be created later
var id_gif: int
var id_webp: int
var animation: Dictionary


func _enter_tree() -> void:
	# install the library
	# (pck can not load libraries so the ONLY solution was to download them from the internet)
	if OS.get_name() == "X11" or OS.get_name() == "Windows":
		install_libraries()
	else:
		# no libraries are available for this OS
		ExtensionsApi.dialog.show_error("Incompatible OS for Extension (CustomExporter)")


func _exit_tree() -> void:
	# remember to remove things that you added using this extension
	ExtensionsApi.exports.remove_export_option(id_gif)
	ExtensionsApi.exports.remove_export_option(id_webp)


########### Library Installer ##############
func install_libraries():
	for link in libraries:
		var base_path = "user://godout_libraries/"
		var dir := Directory.new()
		dir.make_dir_recursive(base_path)
		var file_path = base_path.plus_file(link.get_file())
		# if libraries are already installed in some early session
		if dir.file_exists(file_path):
			current_download += 1
			if current_download >= libraries.size():
				start_native_scripts()
		else:
			var installer = HTTPRequest.new()
			add_child(installer)
			installer.connect("request_completed", self, "library_downloaded", [installer])
			installer.download_file = file_path
			installer.request(link)


func library_downloaded(
		result: int, _response_code: int, _headers: PoolStringArray, _body: PoolByteArray, http
	) -> void:
	http.queue_free()
	if result == HTTPRequest.RESULT_SUCCESS:
		current_download += 1
		if current_download >= libraries.size():
			start_native_scripts()
	else:
		ExtensionsApi.dialog.show_error("Unable to Download Libraries, check your internet connection")


func start_native_scripts():
	# start native scripts now that all libraries are downloaded
	var animation_gif = load("res://addons/godout/animation/gif/gif.gdns")
	animation["gif"] = animation_gif.new()
	# add export options to the ExportDialog
	var info_gif := {"extension": ".gif", "description": "Godout Gif"}
	id_gif = ExtensionsApi.exports.add_export_option(
		info_gif, self, ExtensionsApi.exports.ExportTab.IMAGE, true
	)

	var animation_webp = load("res://addons/godout/animation/webp/webp.gdns")
	animation["webp"] = animation_webp.new()
	# add export options to the ExportDialog
	var info_webp := {"extension": ".webp", "description": "Godout Webp"}
	id_webp = ExtensionsApi.exports.add_export_option(
		info_webp, self, ExtensionsApi.exports.ExportTab.IMAGE, true
	)


###################### where custom exporting is done ################
func override_export(details: Dictionary) -> bool:
	# in this function you take control of image processing and saving from pixelorama
	# return true for SUCCESS, false for FAILURE

	# the (details) include everything you could possibly need for exporting

	# Gather Frames
	var frames := []
	for i in range(len(details["processed_images"])):
		var frame = {
			"content": details["processed_images"][i],
			"duration": details["durations"][i]
		}
		frames.push_back(frame)

	var first_frame: Dictionary = frames[0]
	var first_img: Image = first_frame.content

	var encoder
	if details["project"].file_format == id_gif:
		encoder = animation.gif.get_encoder(first_img.get_width(), first_img.get_height())
	elif details["project"].file_format == id_webp:
		encoder = animation.webp.get_encoder(first_img.get_width(), first_img.get_height())

	if !encoder:
		return false

	prepare_progress_bar(details["export_dialog"], details["processed_images"])
	for v in frames:
		var frame: Dictionary = v
		encoder.add_frame(frame.content.get_data(), int(frame.duration*1000.0))
		increase_export_progress(details["export_dialog"])

	for path in details["export_paths"]:
		var file := File.new()
		file.open(path, File.WRITE)
		file.store_buffer(encoder.get_file_data())
		file.close()

	finish_progress_bar(details["export_dialog"])
	ExtensionsApi.general.get_global().notification_label("File(s) exported")
	return true

######################################################################

# Helper methods created to control progress bar:
# Export progress variables
var export_progress_fraction := 0.0
var export_progress := 0.0

func prepare_progress_bar(export_dialog, processed_images):
	# Export progress popup
	# One fraction per each frame, one fraction for write to disk
	export_progress_fraction = 100.0 / len(processed_images)
	export_progress = 0.0
	export_dialog.set_export_progress_bar(export_progress)
	export_dialog.toggle_export_progress_popup(true)


func increase_export_progress(export_dialog: Node) -> void:
	export_progress += export_progress_fraction
	export_dialog.set_export_progress_bar(export_progress)


func finish_progress_bar(export_dialog):
	export_dialog.toggle_export_progress_popup(false)
