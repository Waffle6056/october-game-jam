extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("menu")):
		visible = not visible


func _on_menu_pressed():
	var menu = get_node("/root/Main/player/Camera2D/Menu")
	menu.visible = true
	visible = false

func _on_restart_pressed():
	var main = get_node("/root/Main")
	var levelname = get_node("/root/Main").get_node("Level").levelpath
	main.remove_child(main.get_node("Level"))
	main.add_child(load(levelname).instantiate())
	visible = false

func _on_next_pressed():
	var main = get_node("/root/Main")
	var levelname = get_node("/root/Main").get_node("Level").nextlevel
	main.remove_child(main.get_node("Level"))
	main.add_child(load(levelname).instantiate())
	visible = false
	
