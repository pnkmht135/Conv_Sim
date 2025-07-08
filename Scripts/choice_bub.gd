extends Node2D
class_name Choice
@onready var speach: Sprite2D = $Speach
var is_correct: bool = false

signal correct_press()
signal incorrect_press()

func _ready() -> void:
	if scale.x<0:
		speach.flip_h=true

func set_correctness(correct:bool,colour:Color)->void:
	show()
	is_correct=correct
	speach.modulate=colour
	
func choice_end()->void:
	hide()
	is_correct = false

func _on_button_pressed() -> void:
	#if is_correct == null:
		#return
	if is_correct:
		emit_signal("correct_press")
	else:
		emit_signal("incorrect_press")
