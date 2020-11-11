extends Node2D

const TILESPAWNER = preload("res://scenes/Tile01.tscn")
const TILEWIDTH = 80 # 80 per tile
var spawn_pos = global_position
onready var player = get_parent().get_parent().get_node("Player")

func _ready():
	pass

func _process(delta):
	
	if spawn_pos.distance_to(player.global_position) < 300:
		spawn_ground()
	
	pass
	
func spawn_ground():
	
	var spawn_ground_instance = TILESPAWNER.instance()
	add_child(spawn_ground_instance)
	spawn_ground_instance.global_position.x = spawn_pos.x
	spawn_ground_instance.global_position.y = spawn_pos.y
	
	randomize()
	
	spawn_pos.x += rand_range(TILEWIDTH, TILEWIDTH + 50)
	spawn_pos.y += rand_range(-50, 50)
