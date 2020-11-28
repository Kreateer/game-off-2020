extends Node

export (int) var oxygen

var score = 0
onready var oxygen_bar = get_node("CanvasLayer/Oxygen/OxygenAnimation/OxygenBar")
onready var oxygen_timer = get_node("CanvasLayer/Oxygen/OxygenTimer")
onready var health_bar = get_node("CanvasLayer/Health/HealthAnimation/HealthBar")
onready var darkness = get_node("Darkness")
onready var def_player_position = $Player/StartPosition.position
onready var player_position = $Player.position


func _ready():
	# Set all values to default oxygen value
	oxygen_bar.max_value = oxygen
	oxygen_bar.value = oxygen
	oxygen_timer.wait_time = oxygen
	new_game()
	call_music()


func _physics_process(delta):
	# Reduce the oxygen bar value by remaining time
	# left in the OxygenTimer
	oxygen_bar.value = oxygen_timer.time_left
	oxygen_animation()

func call_music():
	Levels.current_level("Tutorial")


func new_game():
	# Set default values, reset positions, remove hazards to create a clean
	# game state that won't bubble any changes
	darkness.reset()
	$Player.resetPosition()
	get_tree().call_group("Resettable Pickups", "reset")
	$Player/Sprite.animation = "Idle"
	yield(get_tree().create_timer(0.5), "timeout")
	

	# With a clean game state, reset the UI, timers and any event handlers
	score = 0
	$CanvasLayer/Score.update_score(score)
	$CanvasLayer/Score.show()
	$CanvasLayer/PauseScene.show()
	$Player.resetAttributes()
	$CanvasLayer/Oxygen.show()
	$CanvasLayer/Health.show()
	$CanvasLayer/Health/HealthAnimation.play("100")
	get_tree().call_group("MovementKeys", "play")
	
	# Trigger any timers and create hazards
	darkness.start()
	oxygen_timer.start()
	$CanvasLayer/Score/ScoreTimer.start()
	$Player.show()
	$GUI/FadeIn.play("FadeIn")


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
	$CanvasLayer/Health/HealthAnimation/HealthBar.value = 0
	$CanvasLayer/Oxygen/OxygenAnimation.play("10")
	$CanvasLayer/Oxygen/OxygenTimer.stop()
	$CanvasLayer/Oxygen/OxygenAnimation/OxygenBar.value = 0
	$CanvasLayer/Health/HealthAnimation.play("Death")


# On each tick of the ScoreTimer, evaluate 1 tick worth of score and update
# the score total.
func _on_ScoreTimer_timeout():
	var distance_from_darkness = $Player.position.x - darkness.get_edge_position_x();
	score = score + round((distance_from_darkness / 100) + 1)
	$CanvasLayer/Score.update_score(score)

func _on_EndCollider_level_cleared():
	$EndPopup/BasePopup.show()
