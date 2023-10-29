extends CharacterBody2D

var tilemaps = [0,0,0,0,0,0]
var wait = false
var y = 0

var jank = Vector2(0,0)
var jankbool = false

var jumping = false
var jumptime = 0.5
var jumps = 1

var dashing = false
var dashcalc
var dashes = 1


var airborne = false
var airtime = 0

const dashdis = Vector2(500,500)
const SPEED = 350.0 ## not adjusted


func hover(time):
	if (airtime < 0):
		airtime = 0
	airborne = true
	airtime += time
	set_collision_mask_value(y+1, false)
	

func jump(offset):
	if (jumping):
		airtime -= jumptime
		$JumpTimer.stop()
		$Wiz/AnimationPlayer.stop()
		y -= 1
	jumps -= 1
	jumping = true
	jumptime = 0.5
	hover(0.5)
	y += offset
	$JumpTimer.start()
	$Wiz/AnimationPlayer.play("jump")

func dash(distance, time, dir):
	dashing = true
	dashes -= 1
	hover(0.2)
	$DashTimer.start(time)
	dashcalc = dir * distance
	
func inputs():
	if (Input.is_action_pressed("Up")):
		velocity.y += -1
	if (Input.is_action_pressed("Down")):
		velocity.y += 1
	if (Input.is_action_pressed("Right")):
		velocity.x += 1
	if (Input.is_action_pressed("Left")):
		velocity.x += -1
	velocity.normalized()
	velocity = velocity.normalized() * SPEED
	if (Input.is_action_just_pressed("Jump") and not jumping and jumps > 0):
		jump(1)
	if ((velocity.x != 0 or velocity.y != 0) and not airborne and not wait):
		$Wiz/AnimationPlayer.play("walking")
	if (not airborne):
		dashes = 1
		jumps = 1
	if (Input.is_action_just_pressed("Dash") and not dashing and dashes > 0):
		dash(dashdis,0,get_local_mouse_position().normalized())
	if (dashing):
		velocity += dashcalc
	
	move_and_slide()
	velocity = Vector2(0,0)
	
func _physics_process(delta):
	if (wait):
		return
	jumptime -= delta
	airtime -= delta
	if (airborne and not jumping):
		if ((tilemaps[y].get_cell_atlas_coords(y,tilemaps[y].local_to_map(position)/2)).x != 4):
			set_collision_mask_value(y+1, true)
		else:
			set_collision_mask_value(y+1, false)
	if (airtime <= 0):
		airborne = false
		set_collision_mask_value(y+1, true)
	collcheck()
	
	
	inputs()
	
	
func _ready():
	tilemaps[0] = get_parent().get_node("Level/TileMap1")
	tilemaps[1] = get_parent().get_node("Level/TileMap2")
	tilemaps[2] = get_parent().get_node("Level/TileMap3")
	tilemaps[3] = get_parent().get_node("Level/TileMap4")
	tilemaps[4] = get_parent().get_node("Level/TileMap5")
	tilemaps[5] = get_parent().get_node("Level/TileMap6")
		
func collcheck():
	for index in get_slide_collision_count():
		var coll = get_slide_collision(index)
		if (coll.get_collider().is_in_group("PickUp")):
			coll.get_collider().pick_up(self)
			return
		## the position is divided by 2 because the tilemaps in Main are scaled up by 2
		var cell = tilemaps[y].local_to_map(coll.get_position()/2)
		var tile_id = tilemaps[y].get_cell_atlas_coords(y,cell)
		## tile_id (4,0) is the fall tile
		if (tile_id.x == 4):
			if (airtime < -0.5):
				hover(0.15)
				pass
			set_collision_mask_value(y+1, false)
			y -= 1
			if (y <= -1):
				## TODO needs death function
				$Wiz/AnimationPlayer.stop()
				$Wiz/AnimationPlayer.clear_caches()
				$Wiz/AnimationPlayer.clear_queue()
				$Wiz/AnimationPlayer.play("drop")
				wait = true
				print("fell off map")
			else:
				set_collision_mask_value(y+1, true)
				hover(0.05)
				jank = coll.get_position() - coll.get_normal() + Vector2(0,23)
				$jank.start()
				jankbool = true
		elif (tile_id.x == 0 and jankbool and not jumping):
			position = jank
		
func _on_timer_timeout():
	jumping = false
	

func _on_jank_timeout():
	jankbool = false


func _on_dash_timer_timeout():
	dashing = false
	
