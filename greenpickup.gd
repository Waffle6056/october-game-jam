extends AnimatableBody2D


func pick_up(other):
	print("worked")
	other.jump(1)
	process_mode = Node.PROCESS_MODE_DISABLED
	visible = false
