extends Node2D

var start_score = 0
var score = start_score
onready var animation = $TestPickup

func _physics_process(delta):
	animation.play("default")

func on_pickup():
	if self.visible:
		var main = self.get_parent()
		get_parent().get_node("Invincibility").hide()
		for child in main.get_children():
			if child.name == "Player":
				$DurationTimer.wait_time = 5
				$DurationTimer.start()
				child.set_health(1000)
				EffectController.play_effect("invul")
				hide()
			else:
				pass
		pass
	else:
		pass

func on_Timeout():
	var main = self.get_parent()
	for child in main.get_children():
		if child.name == "Player":
			if child.check_health() > 100:
				child.set_health(100)
			else:
				pass
		else:
			pass

func reset():
	score = start_score
	show()


func _on_PickupArea4_body_entered(body):
	if body is KinematicBody2D:
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
		hide()


func _on_DurationTimer_timeout():
	on_Timeout()
