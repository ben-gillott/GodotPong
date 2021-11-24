extends Node2D


#member variables

export (int) var speed = 3.5 #5 = very hard, 1 = very easy

onready var paddleXPos = global_position.x

func _physics_process(delta):
	#Lock along x axis
	position.x = paddleXPos
	
	#Lerp toward ball at speed
	var ballPosy = get_parent().get_node("Ball").global_position.y
	position.y = lerp(position.y, ballPosy, delta * speed)
	

func setDifficultyEasy():
	speed = 3

func setDifficultyMedium():
	speed = 3.5
	
func setDifficultyHard():
	speed = 4.5
