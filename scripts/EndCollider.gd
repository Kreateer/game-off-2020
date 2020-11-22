extends Node2D

signal level_cleared

func _on_EndArea_body_entered(KinematicBody2D):
	# Pause Game And Show Level End Popup
	get_tree().paused = true
	emit_signal("level_cleared")
	$EndPopup/PopupControl/BasePopup.show()
	var main = self.get_parent()
	for child in main.get_children():
		if child.name == "CanvasLayer":
				$EndPopup/PopupControl/BasePopup/ScoreNumber.text = child.get_child(0).text
