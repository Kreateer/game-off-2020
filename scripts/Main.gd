extends Node

export (int) var oxygen

var score = 0
onready var oxygen_bar = get_node("CanvasLayer/Oxygen/OxygenAnimation/OxygenBar")
onready var oxygen_timer = get_node("CanvasLayer/Oxygen/OxygenTimer")
onready var health_bar = get_node("CanvasLayer/Health/HealthAnimation/HealthBar")
onready var darkness = get_node("Darkness")
onready var def_player_position = $Player/StartPosition.position
onready var player_position = $Player.position

export (Color) var pulse_colo = Color.darkred
export (bool) var will_pulse = false


func _ready():
	# Set all values to default oxygen value
	oxygen_bar.max_value = oxygen
	oxygen_bar.value = oxygen
	oxygen_timer.wait_time = oxygen
	new_game()


#func _process(delta):
#	pass


func _physics_process(delta):
	# Reduce the oxygen bar value by remaining time
	# left in the OxygenTimer
	oxygen_bar.value = oxygen_timer.time_left
	oxygen_animation()


func new_game():
	# Set default values, reset positions, remove hazards to create a clean
	# game state that won't bubble any changes
	darkness.reset()
	$Player.resetPosition()
	get_tree().call_group("Resettable Pickups", "reset")
	yield(get_tree().create_timer(0.5), "timeout")
	$Player.show()

	# With a clean game state, reset the UI, timers and any event handlers
	score = 0
	$CanvasLayer/Score.update_score(score)
	$CanvasLayer/Score.show()
	$CanvasLayer/PauseScene.show()
	$Player.resetAttributes()
	$CanvasLayer/Oxygen.show()
	$CanvasLayer/Health.show()
	$CanvasLayer/Health/HealthAnimation.play("100")
	
	# Trigger any timers and create hazards
	darkness.start()
	oxygen_timer.start()
	$CanvasLayer/Score/ScoreTimer.start()
	#$Music.play()


func oxygen_animation():
	if oxygen_timer.time_left <= 50:
		$CanvasLayer/Oxygen/OxygenAnimation.play("50")
	elif oxygen_timer.time_left <= 10:
		$CanvasLayer/Oxygen/OxygenAnimation.play("10")
	else:
		$CanvasLayer/Oxygen/OxygenAnimation.stop()

# Once OxygenTimer runs out, the Player's oxygen
# effectively expires, which kills the Player.
func _on_OxygenTimer_timeout():
	$Player.player_oxygen(0, true)


# Once the Player 'dies' stop processing any ongoing states
func _on_Player_Dead(cause):
	$CanvasLayer/Score/ScoreTimer.stop()
	darkness.pause()


# On each tick of the ScoreTimer, evaluate 1 tick worth of score and update
# the score total.
func _on_ScoreTimer_timeout():
	var distance_from_darkness = $Player.position.x - darkness.get_edge_position_x();
	score = score + round((distance_from_darkness / 100) + 1)
	$CanvasLayer/Score.update_score(score)
