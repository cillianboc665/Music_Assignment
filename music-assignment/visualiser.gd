extends Control

	
func _on_button_button_down() -> void:
	if $AudioStreamPlayer2D2.playing:
		$Pause.text = "Pause Song"
		$Button.text = "Play Song"
		$AudioStreamPlayer2D2.stop()
	else:
		$Pause.text = "Pause Song"
		$Button.text = "Stop Song"
		$AudioStreamPlayer2D2.play()
	pass # Replace with function body.
	
	

var music_pos = 0.0

func _on_pause_button_down() -> void:
#	var temp = $AudioStreamPlayer2D2.get_playback_position()
	if $AudioStreamPlayer2D2.playing:
		music_pos = $AudioStreamPlayer2D2.get_playback_position()
		$AudioStreamPlayer2D2.stop()
		$Pause.text = "Unpause Song"
	elif !$AudioStreamPlayer2D2.playing:
		$AudioStreamPlayer2D2.play(music_pos)
		$Pause.text = "Pause Song"
	pass # Replace with function body.
	
	
	
func _on_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(value))
	pass # Replace with function body.
	
	
	
func _on_pitch_scale_value_changed(value: float) -> void:
	$AudioStreamPlayer2D2.pitch_scale = value
	pass # Replace with function body.



func _on_button_ph_button_down() -> void:
	if $ButtonPh.text == "Phaser: On":
		$ButtonPh.text = "Phaser: Off"
		AudioServer.set_bus_effect_enabled(0,0, false)
	elif $ButtonPh.text == "Phaser: Off":
		$ButtonPh.text = "Phaser: On"
		AudioServer.set_bus_effect_enabled(0,0, true)
	pass # Replace with function body.

func _on_phaser_value_changed(value: float) -> void:
	var AudioEffectPhaser = AudioServer.get_bus_effect(0, 0)
	AudioEffectPhaser.rate_hz = value
	pass



func _on_button_rev_button_down() -> void:
	if $ButtonRev.text == "Reverb: On":
		$ButtonRev.text = "Reverb: Off"
		AudioServer.set_bus_effect_enabled(0,1, false)
	elif $ButtonRev.text == "Reverb: Off":
		$ButtonRev.text = "Reverb: On"
		AudioServer.set_bus_effect_enabled(0,1, true)
	pass # Replace with function body.




func _on_button_hpf_button_down() -> void:
	if $ButtonHPF.text == "High Pass Filter: On":
		$ButtonHPF.text = "High Pass Filter: Off"
		AudioServer.set_bus_effect_enabled(0,2, false)
	elif $ButtonHPF.text == "High Pass Filter: Off":
		$ButtonHPF.text = "High Pass Filter: On"
		AudioServer.set_bus_effect_enabled(0,2, true)
	pass # Replace with function body.



func _on_button_lpf_button_down() -> void:
	if $ButtonLPF.text == "Low Pass Filter: On":
		$ButtonLPF.text = "Low Pass Filter: Off"
		AudioServer.set_bus_effect_enabled(0,3, false)
	elif $ButtonLPF.text == "Low Pass Filter: Off":
		$ButtonLPF.text = "Low Pass Filter: On"
		AudioServer.set_bus_effect_enabled(0,3, true)
	pass # Replace with function body.
	
	

func _on_button_ch_button_down() -> void:
	if $ButtonCh.text == "Chorus: On":
		$ButtonCh.text = "Chorus: Off"
		AudioServer.set_bus_effect_enabled(0,4, false)
	elif $ButtonCh.text == "Chorus: Off":
		$ButtonCh.text = "Chorus: On"
		AudioServer.set_bus_effect_enabled(0,4, true)
	pass # Replace with function body.
		
	
	
func _on_test_button_down() -> void:
	if $maccies.playing:
		$macciesbutton.text = "McDonald's"
		$maccies.stop()
	else:
		$maccies.play()
	pass # Replace with function body.
	
	

func _on_screech_b_button_down() -> void:
	if $screech.playing:
		$ScreechB.text = "Hell's Kitchen Screech"
		$screech.stop()
	else:
		$screech.play()
	pass # Replace with function body.



func _on_pipe_b_button_down() -> void:
	if $pipe.playing:
		$PipeB.text = "Metal Pipe"
		$pipe.stop()
	else:
		$pipe.play()
	pass # Replace with function body.



func _on_clap_1b_button_down() -> void:
	if $clap1.playing:
		$clap1B.text = "Single Clap"
		$clap1.stop()
	else:
		$clap1.play()
	pass # Replace with function body.



func _on_clap_2b_button_down() -> void:
	if $clap2.playing:
		$clap2B.text = "Multiple Claps"
		$clap2.stop()
	else:
		$clap2.play()
	pass # Replace with function body.



func _on_snare_b_button_down() -> void:
	if $snare.playing:
		$snareB.text = "Snare"
		$snare.stop()
	else:
		$snare.play()
	pass # Replace with function body.



func _on_hihat_b_button_down() -> void:
	if $hihat.playing:
		$hihatB.text = "Hi-Hat"
		$hihat.stop()
	else:
		$hihat.play()
	pass # Replace with function body.



func _on_kick_1b_button_down() -> void:
	if $kick1.playing:
		$kick1B.text = "Reverse Bass Kick"
		$kick1.stop()
	else:
		$kick1.play()
	pass # Replace with function body.



func _on_kick_2b_button_down() -> void:
	if $kick2.playing:
		$kick2B.text = "Bass Kick"
		$kick2.stop()
	else:
		$kick2.play()
	pass # Replace with function body.





@onready
var spectrum = AudioServer.get_bus_effect_instance(1, 0)


@onready
var bottomrightArray = $Circle/right/bottom.get_children()

@onready
var toprightArray = $Circle/right/top.get_children()

@onready
var bottomleftArray = $Circle/left/bottom.get_children()

@onready
var topleftArray = $Circle/left/top.get_children()



const VU_COUNT = 32
const HEIGHT = 70
const FREQ_MAX = 11050.0
const MIN_DB = 70



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bottomleftArray.reverse()
	topleftArray.reverse()
	AudioServer.set_bus_effect_enabled(0,0, false)
	AudioServer.set_bus_effect_enabled(0,1, false)
	AudioServer.set_bus_effect_enabled(0,2, false)
	AudioServer.set_bus_effect_enabled(0,3, false)
	AudioServer.set_bus_effect_enabled(0,4, false)
	pass # Replace with function body.

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var prev_hz = 0
	for i in range(1,VU_COUNT+1):   
		var hz = i * FREQ_MAX / VU_COUNT;
		var f = spectrum.get_magnitude_for_frequency_range(prev_hz,hz)
		var energy = clamp((MIN_DB + linear_to_db(f.length()))/MIN_DB,0,1)
		var height = energy * HEIGHT
		
		prev_hz = hz
		
		var bottomrightRect = bottomrightArray[i - 1]
		
		var toprightRect = toprightArray[i - 1]
		
		var bottomleftRect = bottomleftArray[i - 1]
		
		var topleftRect = topleftArray[i - 1]
		
		var tween = get_tree().create_tween()
		tween.tween_property(bottomrightRect, "size", Vector2(bottomrightRect.size.x, height), 0.05)
		
		tween.tween_property(toprightRect, "size", Vector2(toprightRect.size.x, height), 0.05)
		
		tween.tween_property(bottomleftRect, "size", Vector2(bottomleftRect.size.x, height), 0.05)
		
		tween.tween_property(topleftRect, "size", Vector2(topleftRect.size.x, height), 0.05)
		
	
	pass
	
