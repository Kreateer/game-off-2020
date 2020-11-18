extends Node2D


func on_pickup():
	var main = self.get_parent()
	for child in main.get_children():
		if child.name == "Player":
			child.get_damage(50)
	pass


func _on_PickupArea1_body_entered(KinematicBody2D):
	on_pickup()
	#hide() # Replace with function body.
