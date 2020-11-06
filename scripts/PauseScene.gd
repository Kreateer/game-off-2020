extends Node2D

func _on_Pause_pressed():
		
		if get_tree().paused == true:
			get_tree().paused = false
			$MenuPopup.hide()
		
		else:
			get_tree().paused = true
			$PauseCanvas/MenuPopup.show()
