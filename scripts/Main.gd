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
	get_tree().call_group("Levels", "")
	new_game()
	call_music()

func _physics_process(delta):
	# Reduce the oxygen bar value by remaining time
	# left in the OxygenTimer
	oxygen_bar.value = oxygen_timer.time_left
	yield(get_tree().create_timer(3), "timeout")
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
	$Player/VisibilityNotifier2D.show()
	$GUI/FadeIn.play("FadeIn")


func oxygen_animation():
	if oxygen_timer.time_left <= 50:
		$CanvasLayer/Oxygen/OxygenAnimation.play("50")
	elif oxygen_timer.time_left <= 10:
		EffectController.play_effect("oxylow")
		$CanvasLayer/Oxygen/OxygenAnimation.play("10")
	else:
		$CanvasLayer/Oxygen/OxygenAnimation.stop()

# Once OxygenTimer runs out, the Player's oxygen
# effectively expires, which kills the Player.
func _on_OxygenTimer_timeout():
	EffectController.play_effect("oxynone")
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

func _on_BasePopup_switch_tiles(tilemap):
	
	if tilemap == "Level1":
		$GUI/FadeIn.play("FadeOut")
		$Player/VisibilityNotifier2D.hide()
#		$EndPopup/BasePopup.hide()
		$Level1.collision_layer = 1
		$Level1.collision_mask = 1
		$Level1.show()
		$TileMap.hide(); $TileMap.queue_free()
		get_tree().call_group("MovementKeys", "stop")
		get_tree().call_group("MovementKeys", "hide")
		get_tree().call_group("LevelLabels", "hide")
		
		$Item3.position.x = 674; $Item3.position.y = 903
		$Item4.position.x = 1297; $Item4.position.y = 870
		$Item5.position.x = 2006; $Item5.position.y = 855
		
		$EndPopup/EndCollider.position.x = 3816; $EndPopup/EndCollider.position.y = 662
		
		yield(get_tree().create_timer(2), "timeout")
		
		new_game()
		
		#yield(get_tree().create_timer(2), "timeout")
		#$GUI/FadeIn.play("FadeIn")
	
	if tilemap == "Level2":
		$Level2.show()
		$Level1.hide(); $Level1.queue_free()

	if tilemap == "Level3":
		$Level3.show()
		$Level2.hide(); $Level2.queue_free()
	
	if tilemap == "Level4":
		$Level4.show()
		$Level3.hide(); $Level3.queue_free()
	
	if tilemap == "Level5":
		$Level5.show()
		$Level4.hide(); $Level4.queue_free()
	
	if tilemap == "Level6":
		$Level6.show()
		$Level5.hide(); $Level5.queue_free()
