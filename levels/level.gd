extends Node2D

@export var playerpos = Vector2(0,0)
@export var numhouses = 0
@export var nextlevel = ""
@export var levelpath = ""
@export var order = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("/root/Main/player").position = playerpos
	get_node("/root/Main/player").wait = false
	get_node("/root/Main/player").jump(1)
	get_node("/root/Main/Timer").running = true
	get_node("/root/Main/Timer").time = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (numhouses == 0):
		get_node("/root/Main/player/Camera2D/Control").visible = true
		var timer = get_node("/root/Main/Timer")
		var menu = get_node("/root/Main/player/Camera2D/Menu")
		timer.running = false
		var button = menu.get_node("Panel").get_child(order)
		if (timer.time < button.time):
			button.time = timer.time
			button.update_time()
		process_mode = Node.PROCESS_MODE_DISABLED
