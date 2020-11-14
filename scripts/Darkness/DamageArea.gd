extends Area2D

onready var player = get_tree().current_scene.get_node("/root/Tutorial/Player")

signal PlayerCollision()

var enabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	if !enabled:
		return
	var bodies = self.get_overlapping_bodies()
	for body in bodies:
		if body == player:
			disable()
			emit_signal("PlayerCollision")
			break

func enable():
	if !enabled:
		enabled = true
		
func disable():
	if enabled:
		enabled = false
