extends Button
@onready var timer: Timer = $Timer

func trigger():
	show()
	disabled=false
	timer.start()
	# add logic for having the timer apear as a bar

func _on_timer_timeout() -> void:
	disabled=true
	hide()
