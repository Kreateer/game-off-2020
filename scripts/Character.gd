extends KinematicBody2D

"""
This class provides general functionality for beings in the game. 
"""
class_name Character

signal Dead(cause)

export (int) var movement_speed = 100
export (int) var gravity = 1200
export (int) var jump_speed = -400

var health = max_health
var max_health = 100

var jumping = false
var alive = true
var velocity = Vector2()
var edge_lvl_r = 5
var edge_lvl_l = 8

var screen_size # Empty var to hold screen size
var origin = Vector2()


func get_damage(amount):
	if alive:
		health -= amount
		if health <= 0:
			_die(Constants.HEALTH)
		else:
			print("Damaged {0} points".format([amount]))


# Main death function
func _die(cause):
	if alive:
		alive = false
		emit_signal("Dead", cause)
