extends Control

var running = false

var number = [preload("res://resources/numbers/zero.png"),
			preload("res://resources/numbers/one.png"),
			preload("res://resources/numbers/two.png"),
			preload("res://resources/numbers/three.png"),
			preload("res://resources/numbers/four.png"),
			preload("res://resources/numbers/five.png"),
			preload("res://resources/numbers/six.png"),
			preload("res://resources/numbers/seven.png"),
			preload("res://resources/numbers/eight.png"),
			preload("res://resources/numbers/nine.png"),
			]
var time = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Node2D.position = get_parent().get_node("player").position - get_viewport_rect().size/2
	if (running):
		time += delta
	$Node2D.get_child(0).set_texture(number[int(time)/60/10])
	$Node2D.get_child(1).set_texture(number[int(time)/60-int(time)/60/10*10])
	$Node2D.get_child(2).set_texture(number[int(time)%60/10])
	$Node2D.get_child(3).set_texture(number[int(time)%60-int(time)%60/10*10])
	$Node2D.get_child(4).set_texture(number[int(time*1000)%1000/100])
	$Node2D.get_child(5).set_texture(number[int(time*1000)%1000%100/10])
	$Node2D.get_child(6).set_texture(number[int(time*1000)%1000%100%10])

	
