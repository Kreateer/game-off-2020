extends Popup

signal switch_tiles(tilemap)

onready var tree = get_tree()
onready var current_level = tree.get_current_scene().get_name()

func _on_Continue_pressed():
	# Check current scene and dictionary
	# If current scene is in dictionary and is currently loaded
	# Then load the next level.
	
	var main = self.get_parent().get_parent()
	for child in main.get_children():
		if child.name == "TileMap" && child.visible == true:
			emit_signal("switch_tiles", "Level1")
			self.hide()
			get_tree().paused = false
		else:
			continue
		if child.name == "Level1" && child.visible == true:
			emit_signal("switch_tiles", "Level2")
		else:
			continue
		if child.name == "Level2" && child.visible == true:
			emit_signal("switch_tiles", "Level3")
		else:
			continue
		if child.name == "Level3" && child.visible == true:
			emit_signal("switch_tiles", "Level4")
		else:
			continue
		if child.name == "Level4" && child.visible == true:
			emit_signal("switch_tiles", "Level5")
		else:
			continue
		if child.name == "Level5" && child.visible == true:
			emit_signal("switch_tiles", "Level6")
		else:
			continue
		
		pass
	
#	if current_level == "Tutorial":
#		emit_signal("switch_tiles", "Level1")
#
#	if current_level == "Level1":
#		emit_signal("switch_tiles", "Level2")
#
#	if current_level == "Level2":
#		emit_signal("switch_tiles", "Level3")
#
#	if current_level == "Level3":
#		emit_signal("switch_tiles", "Level4")
#
#	if current_level == "Level4":
#		emit_signal("switch_tiles", "Level5")
#
#	if current_level == "Level5":
#		emit_signal("switch_tiles", "Level6")
	
	


func _on_Exit_pressed():
	tree.quit()
