extends KinematicBody2D

signal hit
export (int) var movement_speed = 100
export (int) var gravity = 1200
export (int) var jump_speed = -400

var velocity = Vector2()
var jumping = false

var edge_lvl_r = 700
var edge_lvl_l = 8

var screen_size # Empty var

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size # Holds the main screen size
	#hide()
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

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	if jumping and is_on_floor():
		jumping = false
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity * delta
	#print(screen_size)
	position.x = clamp(position.x, edge_lvl_l, screen_size.x - edge_lvl_r)

func _on_Player_body_entered(body):
	emit_signal("hit")
