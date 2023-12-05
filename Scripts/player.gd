extends CharacterBody2D

const SPEED = 80.0
const JUMP_VELOCITY = -400.0

# Get Player Scale on X axis
var x = scale.x
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var _animated_sprite = $AnimatedSprite2D

func _process(_delta):
	if Input.is_action_pressed("right") or Input.is_action_pressed("left"):
		_animated_sprite.play("walk")
	else:
		_animated_sprite.stop()
	
	if Input.is_action_just_pressed("right") and scale.x > 0:
		scale = Vector2(-x, scale.y)
		print(x)
	elif Input.is_action_just_pressed("left") and scale.x < 0:
		scale = Vector2(-x, scale.y) 
		print(x)
		
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
