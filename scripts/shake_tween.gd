extends Node

@onready var prompt = get_parent().get_node("PromptText")


var x_max = 2 # max x movement
var r_max = 0   # max rotation
const STOP_THRESHOLD = 0.1 
const TWEEN_DURATION = 0.05
const RECOVERY_FACTOR = 2.0/3
const TRANSITION_TYPE = Tween.TRANS_SINE

signal tween_completed

func _ready() -> void:
	#tween = prompt.create_tween()
	pass 
	
func start():
	var x = x_max
	var r = r_max
	
	var tween = prompt.create_tween()
	tween.tween_property(prompt,"modulate",Color.RED,TWEEN_DURATION)
	tween.tween_property(prompt,"position:x",x,TWEEN_DURATION).as_relative()
	tween.tween_property(prompt,"position:x",-x,TWEEN_DURATION).as_relative()
	tween.tween_property(prompt,"position:x",-x,TWEEN_DURATION).as_relative()
	tween.tween_property(prompt,"position:x",x,TWEEN_DURATION).as_relative()
	tween.tween_property(prompt,"modulate",Color.WHITE,TWEEN_DURATION)
	
	
	# free tween? figure out if create_tween() returns a singleton or not
