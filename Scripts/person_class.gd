extends Node2D
class_name Person

@onready var Speach_Bub: Sprite2D = $Sprite2D
var conv_handler: Conv_handler

func _ready() -> void:
	hide()
	
func speak(Duration:float,Colour)->void:
	modulate=Colour
	show()
	await get_tree().create_timer(Duration).timeout
	conv_handler.someone_speaking = false
	conv_handler.speaker= null
	hide()
