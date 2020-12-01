extends Control

onready var animation = $AnimationPlayer
onready var loading = $AnimationPlayer/Loading

func on_visible():
	if self.visible == true:
		#print("Im working")
		$AnimationPlayer/Loading.show()
		$AnimationPlayer.play("LoadingDots")
	else:
		#print("Im working?")
		$AnimationPlayer.stop()
		$AnimationPlayer/Loading.hide()

func _process(delta):
	on_visible()
