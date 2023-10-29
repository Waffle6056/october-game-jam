extends Button

@export var path = ""
@export var platinum = 0.0
@export var gold = 0.0
@export var silver = 0.0
@export var copper = 0.0
var time = 999999999.9

const save_path = "user://scores.save"

func _ready():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path,FileAccess.READ)
		for i in file.get_length()/4:
			var data = file.get_var(true)
			if (data != null):
				print(data)
				if (data[0] == path):
					time = data[1]
					break
		print(time)
		update_time()
func update_time():
	var timer = get_node("/root/Main/Timer")

	get_child(0).set_texture(timer.number[int(time)/60/10])
	get_child(1).set_texture(timer.number[int(time)/60-int(time)/60/10*10])
	get_child(2).set_texture(timer.number[int(time)%60/10])
	get_child(3).set_texture(timer.number[int(time)%60-int(time)%60/10*10])
	get_child(4).set_texture(timer.number[int(time*1000)%1000/100])
	get_child(5).set_texture(timer.number[int(time*1000)%1000%100/10])
	get_child(6).set_texture(timer.number[int(time*1000)%1000%100%10])
	if (time <= platinum):
		set_button_icon(load("res://resources/medals/plat.png"))
	elif (time <= gold):
		set_button_icon(load("res://resources/medals/gold.png"))
	elif (time <= silver):
		set_button_icon(load("res://resources/medals/silver.png"))
	elif (time <= copper):
		set_button_icon(load("res://resources/medals/copper.png"))
	save_data()

func save_data():
	print("saving")
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var([path,time])
	print("saved")

func _on_pressed():
	var main = get_node("/root/Main")
	main.remove_child(main.get_node("Level"))
	main.add_child(load(path).instantiate())
	get_parent().get_parent().visible = false
