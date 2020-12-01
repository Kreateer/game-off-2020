extends Node2D

signal game_complete

func on_collide():
	# Pause Game And Show Level End Popup
	var EndPopup = get_parent().get_parent().get_node("GameComplete/BasePopup")
	var EndScore = get_parent().get_parent().get_node("GameComplete/BasePopup/ScoreNumber")
	get_tree().paused = true
	EndPopup.show()
	get_parent().get_parent().get_node("GUI/FadeIn/OverlayPanel").show()
	get_parent().get_parent().get_node("GUI/FadeIn").play("FadeOut")
	var main = self.get_parent().get_parent()
	for child in main.get_children():
		if child.name == "CanvasLayer":
				EndScore.text = child.get_child(0).text

func _on_EndArea_body_entered(KinematicBody2D):
	on_collide()
	emit_signal("game_complete")
