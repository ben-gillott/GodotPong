extends KinematicBody2D


#member variables

export (int) var speed = 400
export (float, 0, 1.0) var friction = 0.2
export (float, 0, 1.0) var acceleration = 0.50
var dir = 0
var velocity = Vector2.ZERO

onready var paddleXPos = position.x

func _physics_process(delta):
	#Lock along x axis
	velocity.x = 0
	position.x = paddleXPos
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if dir != 0:
		velocity.y = lerp(velocity.y, dir * speed, acceleration)
	else:
		velocity.y = lerp(velocity.y, 0, friction)
	
func moveUp():
	dir = -1

func moveDown():
	dir = 1

func stopMoving():
	dir = 0
