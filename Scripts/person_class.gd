extends Node2D
class_name Person

@onready var Speach: Sprite2D = $SpeachBub/Speach
@onready var Joke: Sprite2D = $SpeachBub/Joke
var conv_handler: Conv_handler

func _ready() -> void:
	hide()
	
func speak(Duration:float,Colour)->void:
	Speach.modulate=Colour
	Speach.show()
	show()
	await get_tree().create_timer(Duration).timeout
	conv_handler.someone_speaking = false
	conv_handler.speaker= null
	hide()
	Speach.hide()

func joke(Duration:float,Colour)->void:
	Joke.modulate=Colour
	Joke.show()
	show()
	await get_tree().create_timer(Duration).timeout
	conv_handler.someone_speaking = false
	conv_handler.speaker= null
	hide()
	Joke.hide()
	
