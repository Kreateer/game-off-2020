extends Label


func check_score():
	#print(int(self.text))
	return int(self.text)

func update_score(score):
	self.text = str(score)


#	var tutorial = self.get_parent()
#	if tutorial.name == "Tutorial":
#		for child in tutorial.get_children():
#			if child.name == "CanvasLayer":
#				if child.get_child(0).name == "Score":
#					child.text = str(score)
#				else:
#					pass
#	else:
#		pass
	
	#get_node("/root/Player/HUD/Score").text = str(score)
