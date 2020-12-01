extends Node2D

onready var dmg_timer = $DamageTimer
var damage

func _ready():
	dmg_timer.wait_time = 1

#func on_pickup():
#	var main = self.get_parent()
#	for child in main.get_children():
#		if child.name == "Player":
#			child.get_damage(damage)
#	pass


func _on_PickupArea1_body_entered(body):
	if visible:
		if body is KinematicBody2D:
			dmg_timer.start()

func _on_DamageTimer_timeout():
	damage = 10
	var main = self.get_parent()
	for child in main.get_children():
		if child.name == "Player":
			print(damage)
			child.get_damage(damage)
	pass

func _on_PickupArea1_body_exited(body):
	if visible:
		if body is KinematicBody2D:
			dmg_timer.stop()
