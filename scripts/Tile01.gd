extends StaticBody2D

onready var player = get_node("Player")

func _ready():
	pass


func _process(delta):
	
	if global_position.distance_to(player.global_position) > 300 and player.global_position.x > global_position.x:
		get_node(".").call_deferred("queue_free")
	
	pass
