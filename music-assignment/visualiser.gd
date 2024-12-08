extends Control

	
func _on_button_button_down() -> void:
	if $AudioStreamPlayer2D2.playing:
		$Button.text = "Play Song"
		$AudioStreamPlayer2D2.stop()
	else:
#		AudioServer.remove_bus_effect(0, 0)
		AudioServer.set_bus_effect_enabled(0,0, false)
		$Button.text = "Stop Song"
		$AudioStreamPlayer2D2.play()
	pass # Replace with function body.
	
func _on_pitch_scale_value_changed(value: float) -> void:
	$AudioStreamPlayer2D2.pitch_scale = value
	pass # Replace with function body.

func _on_button_ph_button_down() -> void:
	if $ButtonPh.text == "Phaser On":
		$ButtonPh.text = "Phaser Off"
		AudioServer.set_bus_effect_enabled(0,0, false)
#		AudioServer.remove_bus_effect(0, 0)
	elif $ButtonPh.text == "Phaser Off":
		$ButtonPh.text = "Phaser On"
		AudioServer.set_bus_effect_enabled(0,0, true)
	pass # Replace with function body.

func _on_phaser_value_changed(value: float) -> void:
	var AudioEffectPhaser = AudioServer.get_bus_effect(0, 0)
	AudioEffectPhaser.rate_hz = value
	pass



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
	
