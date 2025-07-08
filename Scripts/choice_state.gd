extends State

@export var conv_state: State
@export var Time_lim: float #seconds
@export var time_bar: TextureProgressBar
@export var choice_delta: float
#@export var color_picker: ColorPickerButton
@export var choices: Array[Choice]
var timer
const TIMER_SMOOTH=100
var Current_Colour

func _ready() -> void:
	for choice in choices:
		choice.correct_press.connect(correct_press)
		choice.incorrect_press.connect(incorrect_press)

func within_vibe(colour:Color)->bool:
	if abs(colour[0]-State_machine.current_colour[0])<choice_delta and abs(colour[1]-State_machine.current_colour[1])<choice_delta and abs(colour[2]-State_machine.current_colour[2])<choice_delta:
		return true
	return false

func correct_press()->void:
	print("Nice")
	State_machine.change_state(conv_state)
	
func incorrect_press()->void:
	print("NOOOOO")
	State_machine.change_state(conv_state)

func enter()->void:
	super()
	Current_Colour=State_machine.current_colour
	time_bar.max_value=Time_lim*TIMER_SMOOTH
	time_bar.min_value=0
	time_bar.step=Time_lim/TIMER_SMOOTH
	timer=Time_lim
	time_bar.value=timer*TIMER_SMOOTH
	time_bar.show()
	var incorrect_colour: Color
	for choice in choices:
		incorrect_colour=  Color(randf(),randf(),randf(),)
		choice.set_correctness(within_vibe(incorrect_colour),incorrect_colour)
	var index= choose_correct()
	var correct_colour= Color(
		clamp(Current_Colour[0]+randf_range(-choice_delta,choice_delta),0.2,0.8),
		clamp(Current_Colour[1]+randf_range(-choice_delta,choice_delta),0.2,0.8),
		clamp(Current_Colour[2]+randf_range(-choice_delta,choice_delta),0.2,0.8),
	)
	choices[index].set_correctness(true,correct_colour)
	
func exit()->void:
	for choice in choices:
		choice.choice_end() #redundancy with enter()
	time_bar.hide()
	
func process_frame(delta:float)->State:
	timer-=delta
	time_bar.value=timer*TIMER_SMOOTH
	if timer <=0:
		return conv_state
	return null

func choose_correct()->int:
	return randi_range(0,choices.size()-1)
