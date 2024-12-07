extends Control

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
