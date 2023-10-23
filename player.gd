extends CharacterBody2D

var tilemaps = [0,0,0]
var y = 0
var currentmap

const SPEED = 300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func movey(newy):
	set_collision_mask_value(y+1, false)
	y = newy
	set_collision_mask_value(y+1, true)
	print(y)
	
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
	if (Input.is_action_just_pressed("testjump")):
		movey(y+1)
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
		
		if (tile_id.x == 4):
			set_collision_mask_value(y+1, false)
			y -= 1
			if (y <= -1):
				print("fell off map")
			else:
				set_collision_mask_value(y+1, true)
				position -= coll.get_normal()*18
				print(coll.get_normal())
				
			
			
		
func _process(delta):
	collcheck()

