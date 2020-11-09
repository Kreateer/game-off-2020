extends KinematicBody2D

signal hit
export (int) var movement_speed = 100
export (int) var gravity = 1200
export (int) var jump_speed = -400

var velocity = Vector2()
var jumping = false
var health = 100
var alive = true
var oxygen = 100

var edge_lvl_r = 700
var edge_lvl_l = 8

var screen_size # Empty var

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size # Holds the main screen size
	pass

func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	var jump = Input.is_action_pressed("jump")
	
	if jump and is_on_floor():
		jumping = true
		velocity.y = jump_speed
	if right:
		velocity.x += movement_speed
	if left:
		velocity.x -= movement_speed

func player_damage(amount):
	if alive != false:
		health -= amount
		print("Damaged {0} points".format([amount]))
	else:
		# Show death screen with total score and restart option
		pass
	
func player_heal(amount):
	if health != 100:
		health += amount
		print("Healed {0} points".format([amount]))
	else:
		pass

func player_oxygen(amount):
	if oxygen != 100:
		oxygen -= amount
		print("Oxygen lost {0} points".format([amount]))
	
	pass

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	if jumping and is_on_floor():
		jumping = false
	velocity = move_and_slide(velocity, Vector2(0, -1))
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity * delta
	position.x = clamp(position.x, edge_lvl_l, screen_size.x - edge_lvl_r)

#func _on_Player_body_entered(body):
#	emit_signal("hit")

func _on_PickupItem1_body_entered(body):
	hide()
