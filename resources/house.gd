extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
func asfd():
	process_mode = Node.PROCESS_MODE_DISABLED

func _on_body_entered(_body):
	$Closedhouse.visible = false
	$Openhouse.visible = true
	get_parent().numhouses -= 1
	call_deferred("asfd")
