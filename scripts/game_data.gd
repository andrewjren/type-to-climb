extends RichTextLabel

var mistakes = 0
var altitude = 0

func _ready() -> void:
	_update_display()

func add_mistake():
	mistakes += 1
	_update_display()
	
func add_altitude(inc):
	altitude += inc
	_update_display()
	
func _update_display():
	clear()
	append_text("Mistakes: " + str(mistakes) + " | Altitude: " + str(altitude))
