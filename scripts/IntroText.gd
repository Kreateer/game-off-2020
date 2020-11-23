extends Label

onready var TextDrawSpeed:int = 0
onready var root = get_parent().get_parent().get_parent().get_parent()
onready var label_text = self.text
onready var char_count = len(label_text)

func _process(delta):
	draw_text()

func draw_text():
	var Overlay_Panel = root.get_node("OverlayAnimation/OverlayPanel")
	var Overlay_Animation = root.get_node("OverlayAnimation")
	var Blink_Panel = root.get_node("BlinkAnimation/BlinkPanel")
	var Blink_Animation = root.get_node("BlinkAnimation")
	var Main_Audio = root.get_node("AudioStreamPlayer")
	var Audio_Position = stepify(root.get_node("AudioStreamPlayer").get_playback_position(), 0.1)
	if TextDrawSpeed < char_count:
		TextDrawSpeed += 4
		self.visible_characters = TextDrawSpeed
	else:
		# If the current position is x seconds, hide the Label
		# and play the animations
		print(Audio_Position)
		if Audio_Position == 28.8:
			
			#yield(get_tree().create_timer(11), "timeout")
			self.hide()
			Overlay_Animation.play("FadeIn")
			Overlay_Panel.hide()
			# Add timer before menu shows up
			root.get_node("GUI/AnimationPlayer/Sprite").show()
			root.get_node("GUI/StartButton").show()
			root.get_node("GUI/ExitButton").show()
			Blink_Panel.show()
			Blink_Animation.play("Blink")
				
				
#				if Audio_Position > 38 && Main_Audio.get_playback_position() < 39.1 :
#					Blink_Animation.stop()
#					yield(get_tree().create_timer(1), "timeout")
#				Blink_Animation.play("Blink")
#				if Audio_Position > 76.3 && Audio_Position <= 77.3:
#					Blink_Animation.stop()
#					yield(get_tree().create_timer(1), "timeout")
#				Blink_Animation.play("Blink")
#				if Audio_Position >= 0 && Audio_Position <= 28.8:
#					Blink_Animation.stop()
#					yield(get_tree().create_timer(28.8), "timeout")
#				Blink_Animation.play("Blink")
#			#yield(get_tree().create_timer(57), "timeout")
