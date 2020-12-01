extends Node

var sfx_darkness_proximity = load("res://assets/audio/SFX/Darkness/Lunarun SFX close to darkness.wav")
var sfx_alien_bite = load("res://assets/audio/SFX/Darkness/Alien Noises/Lunarun SFX alien bite.wav")
var sfx_alien_claw = load("res://assets/audio/SFX/Darkness/Alien Noises/Lunarun SFX alien claw sweep.wav")
var sfx_alien_death = load("res://assets/audio/SFX/Darkness/Alien Noises/Lunarun SFX alien death.wav")
var sfx_alien_groan = load("res://assets/audio/SFX/Darkness/Alien Noises/Lunarun SFX alien groan.wav")
var sfx_alien_groan_2 = load("res://assets/audio/SFX/Darkness/Alien Noises/Lunarun SFX alien groan 2.wav")
var sfx_platform_break = load("res://assets/audio/SFX/Environment/Lunarun SFX platform break.wav")
var sfx_oxygen_low = load("res://assets/audio/SFX/Oxygen/Lunarun SFX oxygen low.wav")
var sfx_oxygen_depleted = load("res://assets/audio/SFX/Oxygen/Lunarun SFX oxygen depleted.wav")
var sfx_speed_boost = load("res://assets/audio/SFX/Pickups/Lunarun SFX speed boost.wav")
var sfx_invulnerability = load("res://assets/audio/SFX/Pickups/Lunarun SFX boost pickup 3.wav")
var sfx_ifinite_oxygen = load("res://assets/audio/SFX/Pickups/Lunarun SFX boost pickup 2.wav")


func is_playing():
	return $Effects.playing

func stop_effect():
	$Effects.stop()

func play_effect(type):

	if type == "bite":
		$Effects.stream = sfx_alien_bite
		$Effects.volume_db = -10
		$Effects.play()
	
	if type == "claw":
		$Effects.stream = sfx_alien_claw
		$Effects.volume_db = -10
		$Effects.play()
	
	if type == "death":
		$Effects.stream = sfx_alien_death
		$Effects.volume_db = 5
		$Effects.play()
	
	if type == "groan1":
		$Effects.stream = sfx_alien_groan
		$Effects.volume_db = -10
		$Effects.play()
	
	if type == "groan2":
		$Effects.stream = sfx_alien_groan_2
		$Effects.volume_db = -10
		$Effects.play()
	
	if type == "pbreak":
		$Effects.stream = sfx_platform_break
		$Effects.volume_db = -10
		$Effects.play()
	
	if type == "oxylow":
		$Effects.stream = sfx_oxygen_low
		$Effects.volume_db = -5
		$Effects.play()
	
	if type == "oxynone":
		$Effects.stream = sfx_oxygen_depleted
		$Effects.volume_db = -2
		$Effects.play()
	
	if type == "speed":
		$Effects.stream = sfx_speed_boost
		$Effects.volume_db = -10
		$Effects.play()
	
	if type == "invul":
		$Effects.stream = sfx_invulnerability
		$Effects.volume_db = -5
		$Effects.play()
	
	if type == "infinoxy":
		$Effects.stream = sfx_ifinite_oxygen
		$Effects.volume_db = -5
		$Effects.play()
	
	pass
