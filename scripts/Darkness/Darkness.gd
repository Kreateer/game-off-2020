extends Node2D

signal DamageArea_PlayerCollision()

var DARKNESS_BASE_SPEED = 0.06
# TODO: change based on external factors (ie, powerups, level, difficulty)
var modifier = 10

var enabled = false

func _ready():
	self.visible = false

func _process(delta):
	if enabled:
		var forward = DARKNESS_BASE_SPEED * modifier
		self.translate(Vector2(forward, 0))
		
func _on_DamageArea_PlayerCollision():
	if !enabled:
		return
	pause()
	emit_signal("DamageArea_PlayerCollision")

func start():
	if !enabled:
		enabled = true
		visible = true
		$LightSource/OccluderEdge/DamageArea.enable()
		
func pause():
	if enabled:
		enabled = false
		$LightSource/OccluderEdge/DamageArea.disable()

func reset():
	if enabled:
		enabled = false
	self.position.x = 0
	self.position.y = 0
	visible = false
	
	

