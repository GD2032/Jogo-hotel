extends CharacterBody2D

const SPEED = 80.0
const JUMP_VELOCITY = -400.0

# Get Player Scale on X axis
var x = scale.x
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var _animated_sprite = $AnimatedSprite2D
var Direction = "Right"

func ChangeDirection():
	if Direction == "Left":
		get_node( "AnimatedSprite2D" ).set_flip_h( false )
		Direction = "Right"
	elif Direction == "Right":
		get_node( "AnimatedSprite2D" ).set_flip_h( true )
		Direction = "Left"
		
func _process(_delta):
	if Input.is_action_pressed("right") or Input.is_action_pressed("left"):
		_animated_sprite.play("walk")
	else:
		_animated_sprite.stop()
	
	if Input.is_action_just_pressed("right") and Direction == "Left":
		ChangeDirection()
	elif Input.is_action_just_pressed("left") and Direction == "Right":
		ChangeDirection()
	
	if enter_elevator and Input.is_action_just_pressed("ui_interact"):
		print("Funciona")
	
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

var enter_elevator = false

func _on_area_2d_body_entered(body):
	enter_elevator = true

func _on_area_2d_body_exited(body):
	enter_elevator = false 
