extends Node2D

signal DamageArea_PlayerCollision()

onready var damage_zone = $LightSource/OccluderEdge/DamageArea/DamageZone

var DARKNESS_BASE_SPEED = 0.01
var modifier = 10
var enabled = false
var damage_zone_edge_offset

func _ready():
	self.visible = false
	var shape = damage_zone.shape as RectangleShape2D;
	self.damage_zone_edge_offset = shape.extents.x + damage_zone.position.x

func _process(delta):
	if enabled:
		var forward = DARKNESS_BASE_SPEED * modifier
		self.translate(Vector2(forward, 0))

func _on_DamageArea_PlayerCollision():
	if !enabled:
		return
	pause()
	emit_signal("DamageArea_PlayerCollision")
	
func get_edge_position_x():
	return self.position.x + self.damage_zone_edge_offset;

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
	
	

