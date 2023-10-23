extends Sprite2D

func movement_inputs():
	if (Input.is_action_pressed("Up")):
		

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	movement_inputs()
	pass
