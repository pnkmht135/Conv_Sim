class_name State
extends Node

@export var animation_enter: String
@export var State_machine: State_Machine

var parent: Node2D
var animations: AnimationPlayer

func enter() ->void:
	if animations: 
		animations.play(animation_enter)
	else:
		print("WARNING: no sprite animations found for ", parent.name, self.name)

func exit()-> void:
	pass
	
func process_physics(delta: float) -> State:
	return null

func process_input(event: InputEvent)->State:
	return null

func process_frame(delta: float)->State:
	return null
	
#func want_jump()->bool:
	#return movement_handler.want_jump()
#
#func move()->bool:
	#return movement_handler.move()
	#
#func get_direction()->float:
	#return movement_handler.get_direction()

#func flip_assets(direction: int)->void:
	#animations.flip_h= direction<0
	#if parent.fliplist:
		#for obj in parent.fliplist:
			#obj.scale.x=direction
	#else:
		#print ("No fliplist", parent.name, self.name)
	
