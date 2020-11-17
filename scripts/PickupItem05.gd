extends Node2D

var start_score = 0
var score = start_score

func on_pickup():
	var main = self.get_parent()
	main.oxygen_timer.stop()
	main.oxygen_bar.value = main.oxygen_bar.max_value
	$DurationTimer.wait_time = 5
	$DurationTimer.start()

func on_Timeout():
	var main = self.get_parent()
	main.oxygen_timer.start()
	main.oxygen_bar.value = main.oxygen_timer.time_left

func reset():
	score = start_score


func _on_PickupArea5_body_entered(KinematicBody2D):
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
