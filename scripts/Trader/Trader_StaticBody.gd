extends StaticBody2D

var is_clicked = false

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		is_clicked = event.pressed

func _process(delta):
	if Input.is_mouse_button_pressed(BUTTON_RIGHT) and is_clicked:
		# Open Inventory
		reply()

func reply():
	# Add actual reply as a label
	print("Stop clicking on me! :(")
