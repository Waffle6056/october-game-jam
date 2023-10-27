extends AnimatableBody2D

var l = true
var r = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	look_at(get_global_mouse_position())
	if (Input.is_action_just_pressed("Punch") and not $AnimationPlayer.is_playing()):
		$Lhand.visible = l
		$Rhand.visible = r
		$AnimationPlayer.play("punch")
		l = not l
		r = not r



func _on_animation_player_animation_finished(_anim_name):
	$Lhand.visible = false
	$Rhand.visible = false
