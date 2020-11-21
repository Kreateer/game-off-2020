extends Character

signal healed

var max_oxygen = 100
var oxygen = max_oxygen
onready var animation = get_parent().get_node("CanvasLayer/Health/HealthAnimation")
onready var hp_bar = get_parent().get_node("CanvasLayer/Health/HealthAnimation/HealthBar")

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size # Holds the main screen size
	origin = self.transform.get_origin()
	resetPosition()
	resetAttributes()
	connect("Damaged", self, "_on_Player_Damage")


# Reset the position of the player to the starting point and 
# re-initialize all health / oxygen parameters
func resetPosition():
	self.position = origin


func resetAttributes():	
	health = max_health
	oxygen = max_oxygen
	movement_speed = 100
	alive = true
	hp_bar.max_value = max_health
	hp_bar.value = health


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


# Main player heal function
func player_heal(amount):
	if health != max_health:
		health += amount
		emit_signal("healed")
		print("Healed {0} points".format([amount]))
	else:
		pass

# Sets health value to specific amount
func set_health(amount):
	health = amount

# Checks and returns current player health value
func check_health():
	return health
	

# Main player oxygen function
func player_oxygen(amount, empty = false):
	if oxygen != max_oxygen:
		oxygen -= amount
		print("Oxygen lost {0} points".format([amount]))
	if oxygen <= 0 || empty:
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
		velocity = Vector2()
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if alive: # Only create velocity when player is alive
		position += velocity * delta
		# Clamp Player to screen edge(s), so they don't go off screen
		position.x = clamp(position.x, edge_lvl_l, edge_lvl_r)

# Hide pickup on Player body collision
func _on_PickupItem1_body_entered(body):
	hide()

# Kill Player on Darkness collision
func _on_Darkness_DamageArea_PlayerCollision():	
	_die(Constants.DARKNESS)

# Kill Player when exiting map bounds
func _on_VisibilityNotifier2D_screen_exited():
	_die(Constants.FALL)


func _on_Player_Damage():
	hp_bar.value = health
	if health >= 100 || (health <= 100 && health > 75):
		animation.play("100")
	elif health <= 75 && health > 50:
		animation.play("75")
	elif health <= 50 && health > 25:
		animation.play("50")
	elif health <= 25 && health > 0:
		animation.play("25")
	elif oxygen <= 0:
		animation.play("Death")
	else:
		animation.play("Death")
