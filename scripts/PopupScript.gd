extends Popup


func _on_Unpause_pressed():
	if visible:
		if get_tree().paused == true:
			get_tree().paused = false
			get_node(".").hide()
		else:
			pass
	else:
		pass


func _on_Exit_pressed():
	get_tree().quit()
