extends Node2D

@onready var timer: Timer = $Timer
@onready var progress_bar: ProgressBar = $ProgressBar

var max_time = 30.0

signal out_of_stamina

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	progress_bar.max_value = max_time
	progress_bar.value = max_time
	timer.wait_time = progress_bar.value
	timer.autostart = false
	timer.set_one_shot(true)
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_bar.value = timer.time_left
	#print(str(timer.time_left))

func stop() -> void:
	timer.stop()
	
func start() -> void:
	timer.start()
	
func add_time(dt) -> void:
	var new_time = clamp(timer.get_time_left() + dt,-1,max_time)
	
	if new_time > 0.0:
		timer.start(clamp(timer.get_time_left() + dt,-1,max_time))
	else: 
		timer.stop()
		timer.timeout.emit()

func _on_timer_timeout() -> void:
	out_of_stamina.emit()
