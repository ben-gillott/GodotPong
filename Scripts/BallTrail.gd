extends CPUParticles2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var dir = Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	dir = rad2deg(get_parent().velocity.angle())
	rotation_degrees = dir
	pass
