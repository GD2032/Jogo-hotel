extends Camera2D

var camera
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

	# Animate this to increase/decrease/fade the shaking
var shake_amount = 0.5

func _process(delta):
	if shake :
		set_offset(Vector2( \
		randf_range(-1.0, 1.0) * shake_amount, \
		randf_range(-1.0, 1.0) * shake_amount \
		))

var shake = false
func _on_timer_timeout():
	shake = true# Replace with function body.
	if shake:
		pass

