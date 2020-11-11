extends Label


func update_score(score):
	get_node("/root/Player/HUD/Score").text = str(score)
