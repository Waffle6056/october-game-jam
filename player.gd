extends CharacterBody2D

var tilemaps = [0,0,0]
var y = 0
var currentmap
var jumping = false

const SPEED = 300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func jump(offset):
	jumping = true
	set_collision_mask_value(y+1, false)
	y += offset
	$Wiz/AnimationPlayer.play("jump")
	$JumpTimer.start()
	
func _on_timer_timeout():
	set_collision_mask_value(y+1, true)
	print(y)
	jumping = false
func _physics_process(delta):
	# Add the gravity.
	if (Input.is_action_pressed("Up")):
		velocity.y += -SPEED
	if (Input.is_action_pressed("Down")):
		velocity.y += SPEED
	if (Input.is_action_pressed("Right")):
		velocity.x += SPEED
	if (Input.is_action_pressed("Left")):
		velocity.x += -SPEED
	if (Input.is_action_just_pressed("Jump")):
		jump(1)
	if ((velocity.x != 0 or velocity.y != 0) and not jumping):
		$Wiz/AnimationPlayer.play("walking")
	move_and_slide()
	velocity = Vector2(0,0)
func _ready():
	tilemaps[0] = get_parent().get_node("TileMap1")
	tilemaps[1] = get_parent().get_node("TileMap2")
	tilemaps[2] = get_parent().get_node("TileMap3")
		
func collcheck():
	for index in get_slide_collision_count():
		var coll = get_slide_collision(index)
		var cell = tilemaps[y].local_to_map(coll.get_position()/2)	
		var tile_id = tilemaps[y].get_cell_atlas_coords(y,cell)
		
		if (tile_id.x == 4 and not jumping):
			set_collision_mask_value(y+1, false)
			y -= 1
			if (y <= -1):
				print("fell off map")
			else:
				set_collision_mask_value(y+1, true)
				position -= coll.get_normal()*18
				print(y)
				
			
			
		
func _process(delta):
	collcheck()
 # Replace with function body.
