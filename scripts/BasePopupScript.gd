extends Popup

signal switch_tiles(tilemap)

onready var tree = get_tree()
onready var current_level = tree.get_current_scene().get_name()
onready var tilemaps = {}
var level = 0

func _ready():
	add_tilemaps()

#func _process(delta):
#	return_tilemaps()
#
#func return_tilemaps():
#	print(tilemaps.values())
#	print(tilemaps.keys())

func add_tilemaps():
	var main = self.get_parent().get_parent()
	for child in main.get_children():
		if child is TileMap:
			tilemaps[child.name] = range(7)

func next_level():
	if level <= 6:
		level += 1
		if level == 1:
			emit_signal("switch_tiles", "Level1")
			self.hide()
			#get_tree().paused = false
		
		elif level == 2:
			emit_signal("switch_tiles", "Level2")
			self.hide()
			#get_tree().paused = false
		
		elif level == 3:
			emit_signal("switch_tiles", "Level3")
			self.hide()
			#get_tree().paused = false
		
		elif level == 4:
			emit_signal("switch_tiles", "Level4")
			self.hide()
			#get_tree().paused = false
		
		elif level == 5:
			emit_signal("switch_tiles", "Level5")
			self.hide()
			#get_tree().paused = false
		
		elif level == 6:
			emit_signal("switch_tiles", "Level6")
			self.hide()
			#get_tree().paused = false
		else:
			pass
	else:
		pass

func _on_Continue_pressed():
	# Check current scene and dictionary
	# If current scene is in dictionary and is currently loaded
	# Then load the next level.
	next_level()
#	var loaded0 = false; var loaded1 = false; var loaded2 = false;
#	var loaded3 = false; var loaded4 = false; var loaded5 = false;
#	var loaded6 = false
#	var tm = "TileMap"
#	var l1 = "Level1"
#	var l2 = "Level2"
#	var l3 = "Level3"
#	var l4 = "Level4"
#	var l5 = "Level5"
#	var l6 = "Level6"
#	if not loaded0:
#		emit_signal("switch_tiles", "Level1")
#		self.hide()
#		get_tree().paused = false
#		loaded0 = true
#	else:
#		pass
#
#	if l1 in tilemaps.keys() && not loaded1:
#		emit_signal("switch_tiles", "Level2")
#		self.hide()
#		get_tree().paused = false
#		loaded1 = true
#	else:
#		pass
#
#	if l2 in tilemaps.keys() && not loaded2:
#		emit_signal("switch_tiles", "Level3")
#		self.hide()
#		get_tree().paused = false
#		loaded2 = true
#	else:
#		pass
#
#	if l3 in tilemaps.keys() && not loaded3:
#		emit_signal("switch_tiles", "Level4")
#		self.hide()
#		get_tree().paused = false
#		loaded3 = true
#	else:
#		pass
#
#	if l4 in tilemaps.keys() && not loaded4:
#		emit_signal("switch_tiles", "Level5")
#		self.hide()
#		get_tree().paused = false
#		loaded4 = true
#	else:
#		pass
#
#	if l5 in tilemaps.keys() && not loaded5:
#		emit_signal("switch_tiles", "Level6")
#		self.hide()
#		get_tree().paused = false
#		loaded5 = true
#	else:
#		pass
#
#	pass
	
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
