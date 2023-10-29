extends AnimatableBody2D


func pick_up(other):
	print("worked")
	print(position)
	print(to_global($CollisionShape2D.position))
	other.dash(Vector2(1000,1000),0,(position-to_global($CollisionShape2D.position)).normalized())
	process_mode = Node.PROCESS_MODE_DISABLED
	visible = false
