class_name State_Machine
extends Node

@export var starting_state: State
@export var parent: Node2D
@export var animations: AnimationPlayer
var current_state: State
var current_colour: Color

func _ready() -> void:
#func init(parent: Node2D, 
			#animations : AnimationPlayer)->void:
	# Set parent for all states in the machine 
	for child in get_children():
		child.parent=parent
		child.animations=animations
	# enter starting state
	#change_state(starting_state) #change, we dont want the switch animation to play
	current_state=starting_state

func change_state(new_state: State):
	# exit current state if applicable
	if current_state:
		current_state.exit()
	# enter new state
	current_state=new_state
	current_state.enter()

func _physics_process(delta: float) -> void:
#func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)
		
func process_input(event: InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)

func _process(delta: float) -> void:
#func process_frame(delta: float):
	var new_state =  current_state.process_frame(delta)
	if new_state:
		change_state(new_state)
# check wtf a frame is and why i would need a func for it 
