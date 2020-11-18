extends KinematicBody2D

signal Dead(cause)

export (int) var movement_speed = 100
export (int) var gravity = 1200
export (int) var jump_speed = -400

var velocity = Vector2()
var jumping = false
var max_health = 100
var max_oxygen = 100
var alive = true
var oxygen = max_oxygen
var health = max_health

var edge_lvl_r = 5
var edge_lvl_l = 8

var screen_size # Empty var to hold screen size
var origin = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size # Holds the main screen size
	origin = self.transform.get_origin()
	reset()

# Reset the position of the player to the starting point and 
# re-initialize all health / oxygen parameters
func reset():	
	self.position.x = origin.x
	self.position.y = origin.y
	health = max_health
	oxygen = max_oxygen
	movement_speed = 100
	alive = true

# Main Player movement
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

# Main player damage function
func player_damage(amount):
	if !alive:
		return
	health -= amount
	print("Damaged {0} points".format([amount]))
	if health <= 0:
		_die(Constants.HEALTH)

# Main player heal function
func player_heal(amount):
	if health != max_health:
		health += amount
		print("Healed {0} points".format([amount]))
	else:
		pass

# Sets health value to specific amount
func set_health(amount):
	self.health = amount

# Checks and returns current player health value
func check_health():
	return self.health

# Main player oxygen function
func player_oxygen(amount, empty = false):
	if oxygen != max_oxygen:
		oxygen -= amount
		print("Oxygen lost {0} points".format([amount]))	
	if oxygen <= 0 || empty == true:
		_die(Constants.SUFFOCATE)

# Sets oxygen value to specific amount
func set_oxygen(amount):
	self.oxygen = amount

# Checks and returns current player oxygen value
func check_oxygen():
	return self.oxygen

func _physics_process(delta):
	if alive: # Only create velocity when player is alive
		get_input()
		velocity.y += gravity * delta
		if jumping and is_on_floor():
			jumping = false
	else:
		velocity = Vector2(0, 0)
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if alive: # Only create velocity when player is alive
		position += velocity * delta
		# Clamp Player to screen edge(s), so they don't go off screen
		position.x = clamp(position.x, edge_lvl_l, screen_size.x - edge_lvl_r)

# Hide pickup on Player body collision
func _on_PickupItem1_body_entered(body):
	hide()

# Kill Player on Darkness collision
func _on_Darkness_DamageArea_PlayerCollision():	
	_die(Constants.DARKNESS)

# Kill Player when exiting map bounds
func _on_VisibilityNotifier2D_screen_exited():
	_die(Constants.FALL)

# Main Player death function
func _die(cause):
	if alive:
		alive = false
		emit_signal("Dead", cause)
