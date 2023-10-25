extends CharacterBody2D

var tilemaps = [0,0,0]
var y = 0
var currentmap
var jumping = false
var jank = Vector2(0,0)
var jankbool = false
var dashing = false
var dashcalc
var wait = false

const dashdis = Vector2(500,500)
const SPEED = 300.0 ## not adjusted

func jump(offset):
	jumping = true
	set_collision_mask_value(y+1, false)
	y += offset
	$JumpTimer.start()
	$Wiz/AnimationPlayer.play("jump")

	
func _physics_process(delta):
	if (wait):
		return
	if (Input.is_action_pressed("Up")):
		velocity.y += -SPEED
	if (Input.is_action_pressed("Down")):
		velocity.y += SPEED
	if (Input.is_action_pressed("Right")):
		velocity.x += SPEED
	if (Input.is_action_pressed("Left")):
		velocity.x += -SPEED
	if (Input.is_action_just_pressed("Jump") and not jumping):
		jump(1)
	if ((velocity.x != 0 or velocity.y != 0) and not jumping):
		$Wiz/AnimationPlayer.play("walking")
	if (not dashing and Input.is_action_just_pressed("Dash")):
		dashing = true
		$DashTimer.start()
		dashcalc = get_local_mouse_position().normalized() * dashdis
	if (dashing):
		velocity += dashcalc
	
	move_and_slide()
	velocity = Vector2(0,0)
	
func _ready():
	tilemaps[0] = get_parent().get_node("TileMap1")
	tilemaps[1] = get_parent().get_node("TileMap2")
	tilemaps[2] = get_parent().get_node("TileMap3")
		
func collcheck():
	for index in get_slide_collision_count():
		var coll = get_slide_collision(index)
		## the position is divided by 2 because the tilemaps in Main are scaled up by 2
		var cell = tilemaps[y].local_to_map(coll.get_position()/2)
		var tile_id = tilemaps[y].get_cell_atlas_coords(y,cell)
		## tile_id (4,0) is the fall tile
		if (tile_id.x == 4 and not jumping and not dashing):
			set_collision_mask_value(y+1, false)
			y -= 1
			if (y <= -1):
				
				## TODO needs death function
				$Wiz/AnimationPlayer.play("drop")
				wait = true
				print("fell off map")
			else:
				set_collision_mask_value(y+1, true)
				
				## TODO needs to not be terrible
				jank = coll.get_position() - coll.get_normal() + Vector2(0,23)
				$jank.start()
				jankbool = true
				print(y)
		elif (jankbool and tile_id.x == 0 and not jumping):
			position = jank
		
func _process(delta):
	collcheck()

func _on_timer_timeout():
	set_collision_mask_value(y+1, true)
	print(y)
	jumping = false
	

func _on_jank_timeout():
	jankbool = false


func _on_dash_timer_timeout():
	dashing = false
	
