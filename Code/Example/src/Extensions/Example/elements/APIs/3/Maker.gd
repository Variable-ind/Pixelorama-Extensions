extends Node


static func make(save_path: String, extension_name: String, template := MainGd.ADD_PANNEL) -> int:
	var extension_path = save_path.plus_file("src/Extensions/").plus_file(extension_name)
	var project = ProjectGodot.new()
	var project_path = save_path.plus_file("project.godot")
	var export_cfg = ExportCfg.new()
	var export_cfg_path = save_path.plus_file("export_presets.cfg")
	var main_tscn = MainTscn.new()
	var main_tscn_path = extension_path.plus_file("Main.tscn")
	var main_gd = MainGd.new()
	var main_gd_path = extension_path.plus_file("Main.gd")
	var api = Api.new()
	var api_path = extension_path.plus_file("API")

	# Step 1 : make extension files first
	var file = File.new()
	file.open(project_path, File.WRITE)
	file.store_string(project.make(extension_name))
	file.close()
	file.open(export_cfg_path, File.WRITE)
	file.store_string(export_cfg.make(extension_name))
	file.close()
	file.open(main_tscn_path, File.WRITE)
	file.store_string(main_tscn.make(extension_name))
	file.close()
	file.open(main_gd_path, File.WRITE)
	file.store_string(main_gd.make(template))
	file.close()
	if template == MainGd.ADD_THEME:
		var theme: Theme = ExtensionsApi.theme.get_theme()
		ResourceSaver.save(save_path.plus_file("Theme.tres"), theme)

#	# Step 2 : Now make Api Files
	var err = api.generate_api_files(api_path)
	if err != OK:
		return err
	return 0


class ProjectGodot:
	var text = (
"""
; Engine configuration file.
; It's best edited using the editor UI and not directly,
; since the parameters that go here are not all obvious.
;
; Format:
;   [section] ; section goes between []
;   param=value ; assign values to parameters

config_version=4

[application]

config/name="Example"
config/description="A pixelorama Extention (The \"Name\" and \"Description\" field are not related to extention system so they can be anything)"
run/main_scene="res://src/Extensions/Example/Main.tscn"

[autoload]

ExtensionsApi="*res://src/Extensions/Example/API/ExtensionsApi.gd"

[physics]

common/enable_pause_aware_picking=true

[rendering]

quality/driver/driver_name="GLES2"
vram_compression/import_etc=true
vram_compression/import_etc2=false
"""
)

	func make(extension_name: String):
		return text.replace("Example", extension_name)


class ExportCfg:
	var text = (
"""
[preset.0]

name="Export Extension (PCK)"
platform="Windows Desktop"
runnable=true
custom_features=""
export_filter="all_resources"
include_filter="*.json"
exclude_filter="res://src/Extensions/Example/API"
export_path=""
script_export_mode=1
script_encryption_key=""

[preset.0.options]

custom_template/debug=""
custom_template/release=""
binary_format/64_bits=true
binary_format/embed_pck=false
texture_format/bptc=false
texture_format/s3tc=true
texture_format/etc=false
texture_format/etc2=false
texture_format/no_bptc_fallbacks=true
codesign/enable=false
codesign/identity=""
codesign/password=""
codesign/timestamp=true
codesign/timestamp_server_url=""
codesign/digest_algorithm=1
codesign/description=""
codesign/custom_options=PoolStringArray(  )
application/icon=""
application/file_version=""
application/product_version=""
application/company_name=""
application/product_name=""
application/file_description=""
application/copyright=""
application/trademarks=""
"""
)

	func make(extension_name: String):
		return text.replace("Example", extension_name)


class MainTscn:
	var text = (
"""
[gd_scene load_steps=2 format=2]

[ext_resource path="res://src/Extensions/%s/Main.gd" type="Script" id=1]

[node name="Main" type="Node"]
script = ExtResource( 1 )
"""
)

	func make(extension_name: String):
		return text % extension_name


class MainGd:
	enum { BARE_MINIMUM, ADD_PANNEL, ADD_MENU_ITEM, ADD_THEME, PROJECT_MANIPULATOR, NEW_EXPORTER }
	var base_path = "res://src/Extensions/Example/elements/APIs/3"
	var scripts := {
		BARE_MINIMUM : "Files/Templates/bare_minimum.gd",
		ADD_PANNEL : "Files/Templates/add_pannel.gd",
		ADD_MENU_ITEM: "Files/Templates/add_menu_item.gd",
		ADD_THEME: "Files/Templates/add_theme.gd",
		PROJECT_MANIPULATOR: "Files/Templates/project_manipulator.gd",
		NEW_EXPORTER: "Files/Templates/add_exporter.gd",
	}

	func make(idx: int):
		var script_path = scripts[BARE_MINIMUM]
		if idx in scripts.keys():
			script_path = scripts[idx]
		var file := File.new()
		# warning-ignore:return_value_discarded
		file.open(base_path.plus_file(script_path), File.READ)
		var text = file.get_as_text()
		file.close()
		return text


class Api:
	var base_path = "res://src/Extensions/Example/elements/APIs/3"
	var scripts := {
		"ExtensionsApi.gd" : "Files/ExtensionsApi.gd",
		"EmptyClasses/GIFAnimationExporter.gd": "Files/Classes/AnimationExporters/GIFAnimationExporter.gd",
		"EmptyClasses/SelectionTool.gd": "Files/Classes/Tools/SelectionTools/SelectionTool.gd",
		"EmptyClasses/BaseTool.gd": "Files/Classes/Tools/BaseTool.gd",
		"EmptyClasses/AnimationTag.gd": "Files/Classes/AnimationTag.gd",
		"EmptyClasses/BaseCel.gd": "Files/Classes/BaseCel.gd",
		"EmptyClasses/BaseLayer.gd": "Files/Classes/BaseLayer.gd",
		"EmptyClasses/Cel3D.gd": "Files/Classes/Cel3D.gd",
		"EmptyClasses/Cel3DObject.gd": "Files/Classes/Cel3DObject.gd",
		"EmptyClasses/Drawers.gd": "Files/Classes/Drawers.gd",
		"EmptyClasses/Frame.gd": "Files/Classes/Frame.gd",
		"EmptyClasses/GroupCel.gd": "Files/Classes/GroupCel.gd",
		"EmptyClasses/GroupLayer.gd": "Files/Classes/GroupLayer.gd",
		"EmptyClasses/ImageEffect.gd": "Files/Classes/ImageEffect.gd",
		"EmptyClasses/Layer3D.gd": "Files/Classes/Layer3D.gd",
		"EmptyClasses/ObjParse.gd": "Files/Classes/ObjParse.gd",
		"EmptyClasses/PixelCel.gd": "Files/Classes/PixelCel.gd",
		"EmptyClasses/PixelLayer.gd": "Files/Classes/PixelLayer.gd",
		"EmptyClasses/Project.gd": "Files/Classes/Project.gd",
		"EmptyClasses/SelectionMap.gd": "Files/Classes/SelectionMap.gd",
		"EmptyClasses/ShaderImageEffect.gd": "Files/Classes/ShaderImageEffect.gd",
		"EmptyClasses/Tiles.gd": "Files/Classes/Tiles.gd",
	}
	func generate_api_files(api_path: String) -> int:
		var dir := Directory.new()
		var err = dir.make_dir_recursive(api_path)
		if err != OK:
			return err
		err = dir.make_dir_recursive(api_path.plus_file("EmptyClasses"))
		if err != OK:
			return err
		var file := File.new()
		for script in scripts.keys():
			err = file.open(base_path.plus_file(scripts[script]), File.READ)
			if err != OK:
				return err
			var text = file.get_as_text()
			file.close()
			err = file.open(api_path.plus_file(script), File.WRITE)
			if err != OK:
				return err
			file.store_string(text)
			file.close()
		return 0
