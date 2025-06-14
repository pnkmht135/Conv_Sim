extends Node2D
class_name Player

@onready var thought: Button = $Thought
@export var thought_dur: float

func _ready() -> void:
	thought.disabled=true
	thought.hide()

func participate():
	thought.trigger()
	
