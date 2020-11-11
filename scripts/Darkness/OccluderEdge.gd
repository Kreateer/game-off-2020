extends LightOccluder2D

var rng = RandomNumberGenerator.new()
var original = PoolVector2Array()
var offsets = Array()
var durations = Array()


var flux_width = 20
var size = 200
# TODO: limit to camera size, no need to fluctuate the entire width

var forward = 0; # TODO: Progressively spawning further right in later levels

var flux_half = flux_width / 2
var flux_min = -flux_half
var flux_max = flux_half

var animation_enabled = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if !animation_enabled:
		return
	occluder = self.get_occluder_polygon()
	var first = occluder.polygon[0]
	var second = occluder.polygon[1]
	original.append(first)
	offsets.append(null)
	durations.append(null)
	var segment = second - first
	for i in range(1, size - 2):
		original.append(Vector2(first.x, first.y + (segment.y * i)))
		offsets.append(null)
		durations.append(null)
	original.append(second)
	offsets.append(null)
	durations.append(null)
	occluder.set_polygon(original)

func _process(delta):
	if !animation_enabled:
		return
	var polygon = occluder.get_polygon()		
	for i in range(1, size - 2):
		if offsets[i] == null:
			if rng.randf() < 0.8:
				continue
			var source = original[i]
			var x = source.x + forward + rng.randi_range(flux_min, flux_max)
			var y = source.y + rng.randi_range(-5, 5) # TODO: distribute polygon evenly
			var current = polygon[i]
			var duration = rng.randi_range(60, 130)
			offsets[i] = Vector2((x - current.x) / duration, (y - current.y) / duration)
			durations[i] = Vector2(0, duration)
			continue
		var duration = durations[i]
		if (duration.y <= 0):
			durations[i] = null;
			offsets[i] = null;
			continue
		durations[i] = Vector2(duration.x, duration.y - 1)
		var offset = offsets[i]
		var current = polygon[i]
		polygon.set(i, Vector2(current.x + offset.x, current.y + offset.y))
		continue
	occluder.set_polygon(polygon)
	pass
