extends Node2D

var start_score = 0
var score = start_score

func on_pickup():
	var main = self.get_parent()
	for child in main.get_children():
		if child.name == "Player":
			$DurationTimer.wait_time = 5
			$DurationTimer.start()
			child.movement_speed = 200
		else:
			pass
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
				score += 100
				node.get_child(0).update_score(score)
		else:
			pass
	on_pickup()
	#hide() # Replace with function body.


func _on_DurationTimer_timeout():
	on_Timeout()
