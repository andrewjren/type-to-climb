extends Node

var dict_1 = []
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var file = FileAccess.open("res://text/dict_1.dat", FileAccess.READ)
	
	while !file.eof_reached():
		var line = file.get_csv_line()
		dict_1.push_back(line[0])

func generate_word() -> String:
	var idx = rng.randi_range(0,len(dict_1))
	return dict_1[idx]
