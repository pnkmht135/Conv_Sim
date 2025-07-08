extends State
class_name Conv_handler

@export var Debuger: Label
@export var Choice_State: State
# List of all the people that may speak in the level
@export var People: Array[Person]
@export var Player: Player
var Num_People: int = 1 
# The time thta SBs stay up, and the time between them
@export var SB_Dur: float
@export var SB_Gap: float
@export var participate_Gap: float
# The range of random variation, randf_range(-delta,delta), for SB Dur and Gap
@export var Dur_delta: float
@export var Gap_delta: float
@export var Part_delta:float
# how much will colour change between SBs
@export var Vibe_delta: float
# How often a participation oppurtunity arises
@onready var choice_view: Sprite2D = %Choice_view
@onready var convo_view: Sprite2D = %Convo_view
#@onready var camera_2d: Camera2D = %Camera2D
@onready var camera_animation: AnimationPlayer = %CameraAnimation

var Current_Colour: Color
var Gaptimer: float
var Durtimer: float
var Participatetimer:float

var speaker: Person
var someone_speaking: bool = false

func _ready() -> void:
	Num_People=People.size()
	print(Num_People)
	for person in People:
		person.conv_handler=self
	Current_Colour= _generate_random_rgb_color()
	set_SB_timings()
	set_part_timing()
	Player.thought.pressed.connect(thought_pressed)

func thought_pressed()->void:
	if someone_speaking:
		Player.modulate=Color.RED
		await get_tree().create_timer(0.5).timeout
		Player.modulate=Color.WHITE
		return
	#print("EPIC!")
	#camera_animation.play("to_choice")
	Player.thought.disabled=true
	Player.thought.hide()
	State_machine.change_state(Choice_State)
	
func _generate_random_rgb_color() -> Color:
	return Color(
		randf_range(0.2,0.8), # RED
		randf_range(0.2,0.8), # GREEN
		randf_range(0.2,0.8), # BLUE
	)

func set_SB_timings()->void:
	Durtimer=max(SB_Dur+randf_range(-Dur_delta,Dur_delta),0)
	Gaptimer=max(SB_Gap+randf_range(-Gap_delta,Gap_delta)+Durtimer,0)
func set_part_timing()->void:
	Participatetimer=max(participate_Gap+randf_range(-Part_delta,Part_delta),0)

func colour_drift()->void:
	if !Current_Colour:
		pass
	var drift = Color(
		clamp(Current_Colour[0]+randf_range(-Vibe_delta,Vibe_delta),0.2,0.8),
		clamp(Current_Colour[1]+randf_range(-Vibe_delta,Vibe_delta),0.2,0.8),
		clamp(Current_Colour[2]+randf_range(-Vibe_delta,Vibe_delta),0.2,0.8),
	)
	Current_Colour=drift
	

func get_person()->Person:
	var person=People[randi_range(0,Num_People-1)]
	#print(person.name)
	return person
	

func process_frame(delta: float) -> State:
	if Debuger:
		Debuger.text="Someone_speaking: "+str(someone_speaking)+"\nSpeaker: "+str(speaker)+"\nTopic: "+str(Current_Colour)
	Gaptimer-=delta
	Participatetimer-=delta
	if Gaptimer<=0:
		speaker=get_person()
		set_SB_timings()
		colour_drift()
		someone_speaking=true
		speaker.speak(Durtimer,Current_Colour)
	if Participatetimer<=0:
		Player.participate()
		set_part_timing()
	return null
	
func exit()->void:
	State_machine.current_colour=Current_Colour
	super()
