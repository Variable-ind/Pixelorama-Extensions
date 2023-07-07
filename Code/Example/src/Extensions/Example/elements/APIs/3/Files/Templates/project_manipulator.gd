extends Node

# I will show you some common stuff to manipulate projects
# (I will make use of the menu api as well)

# To know the available methods of (timeline) see:
# https://github.com/Orama-Interactive/Pixelorama/blob/master/src/UI/Timeline/AnimationTimeline.gd

# NOTE: some more advanced methods can be accessed from timeline node (un-comment line below to get them)
#onready var timeline = ExtensionsApi.general.get_global().animation_timeline


var item_id: int
var type: int
func _enter_tree() -> void:
	type = ExtensionsApi.menu.EDIT
	item_id = ExtensionsApi.menu.add_menu_item(type, "Click Me 4 times", self)


func _exit_tree() -> void:  # Extension is being uninstalled or disabled
	# remember to remove things that you added using this extension
	ExtensionsApi.menu.remove_menu_item(type, item_id)


################## Test Project methods whenever we click the menu button ############
var thing_to_do := 0
var new_project: Project
var dest_img: Image
func menu_item_clicked():
	# Do some stuff
	if thing_to_do == 0:
		# get an image (For testing) from the current cel
		dest_img = ExtensionsApi.project.get_current_cel().get_image()
		# also make a new project
		new_project = ExtensionsApi.project.new_project([], "Test", Vector2(64, 64))
	if thing_to_do == 1:
		# To change something or get something in a project we must make it our "current_project" first
		ExtensionsApi.project.switch_to(new_project)
	if thing_to_do == 2:
		# Add 3 frames (the new_project will now have 4 total frames)
		for i in range(3):
			ExtensionsApi.project.add_new_frame(0)
	if thing_to_do == 3:
		# Add a PixelLayer
		ExtensionsApi.project.add_new_layer(0, "I Love Pixelorama")
	if thing_to_do == 4:
		# Now change content at {frame 3, layer 1} of "new_project"
		ExtensionsApi.project.set_pixelcel_image(dest_img, 2, 0)  # {frame 3, layer 1}
	thing_to_do += 1
