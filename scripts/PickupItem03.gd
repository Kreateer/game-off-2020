extends Node2D

var start_score = 0
var score = start_score
onready var animation = $TestPickup

func _physics_process(delta):
	animation.play("default")

func on_pickup():
	var main = self.get_parent()
	for child in main.get_children():
		if child.name == "Player":
			$DurationTimer.wait_time = 5
			$DurationTimer.start()
			child.movement_speed = 200
		else:
			pass
	#hide()
	pass

func on_Timeout():
	var main = self.get_parent()
	for child in main.get_children():
		if child.name == "Player":
			if child.movement_speed != 100:
				child.movement_speed = 100
			else:
				pass
		else:
			pass
	pass

func reset():
	score = start_score


func _on_PickupArea3_body_entered(KinematicBody2D):
	var parent = self.get_parent()
	for node in parent.get_children():
		if node.name == "CanvasLayer":
			if node.get_child(0).name == "Score":
				score = node.get_child(0).check_score()
				var new_score = start_score + 100
				if score >= new_score or score <= new_score:
					new_score = score + 100
					node.get_child(0).update_score(new_score)
#				elif score > new_score:
#					new_score == score + 100
#					node.get_child(0).update_score(new_score)
#				elif score < new_score:
#					new_score == score + 100
#					node.get_child(0).update_score(new_score)
				else:
					pass
		else:
			pass
	on_pickup()
	#hide() # Replace with function body.


func _on_DurationTimer_timeout():
	on_Timeout()
