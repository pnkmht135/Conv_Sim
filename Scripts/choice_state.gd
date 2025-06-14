extends State

@export var conv_state: State
@export var Time_lim: float #seconds
@export var time_bar: TextureProgressBar
var timer

func enter()->void:
	super()
	time_bar.max_value=Time_lim*100
	time_bar.min_value=0
	time_bar.step=Time_lim/100
	timer=Time_lim
	time_bar.value=timer*100
	time_bar.show()
	#time_bar.dis
	
func exit()->void:
	time_bar.hide()
	
func process_frame(delta:float)->State:
	timer-=delta
	time_bar.value=timer*100
	if timer <=0:
		return conv_state
	return null
		
