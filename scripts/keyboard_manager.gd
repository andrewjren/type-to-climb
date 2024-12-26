extends Node2D

@onready var prompt_text: RichTextLabel = $PromptText
@onready var game_data: RichTextLabel = %GameData
@onready var countdown: Node2D = %Countdown
@onready var climber: CharacterBody2D = %Climber
@onready var shake_tween: Node = $ShakeTween
@onready var word_manager: Node = $WordManager


@onready var prompt = word_manager.generate_word()
var prompt_idx = 0
var rng = RandomNumberGenerator.new()
var next_target

var UNTYPED_COLOR = Color.WHITE_SMOKE
var TYPED_COLOR = Color.DIM_GRAY
var RECOVERY = 3.0
var STAMINA_DAMAGE = -2.0

# helper function to shade word correctly
func _color_word():
	prompt_text.clear()
	prompt_text.push_color(TYPED_COLOR)
	prompt_text.append_text(prompt.substr(0,prompt_idx))
	prompt_text.push_color(UNTYPED_COLOR)
	prompt_text.append_text(prompt.substr(prompt_idx,-1))

# helper function to generate new position 
func _new_position() -> Vector2:
	position.y -= 50
	position.x += rng.randf_range(-20.0,20.0)
	
	return Vector2(position.x, position.y)

func _ready() -> void:
	_color_word()
	next_target = _new_position()


func _input(event):
	# get unicode for ascii comparison
	var curr_unicode = prompt.unicode_at(prompt_idx)
	
	# check if key is input key
	if event is InputEventKey and event.pressed:
		#print(str(event.get_unicode()))
		# ignore special keys
		var key_str = OS.get_keycode_string(event.keycode)
		if key_str.length() == 1 || key_str == "Space":
			
			# if it matches
			if event.get_unicode() == int(curr_unicode):
				#print(prompt[prompt_idx] + " was typed!")
				prompt_idx += 1
				_color_word()
				
			# if it doesn't match
			else:
				game_data.add_mistake()
				# subtract time from countdown
				countdown.add_time(STAMINA_DAMAGE)
				shake_tween.start()
	
	# word finished 
	if prompt_idx >= prompt.length():
		prompt_text.clear()
		
		# re-roll word
		prompt = word_manager.generate_word()
		prompt_idx = 0
		_color_word()
		
		# add time to countdown
		countdown.add_time(RECOVERY)
		
		# move climber
		climber.update_target(next_target)
		game_data.add_altitude(50)
		
		# move text
		next_target = _new_position()
		
