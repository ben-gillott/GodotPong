extends Node2D

onready var ballStartPos = $Ball.position
onready var paddle1StartPos = $Player1.get_child(0).position
onready var paddle2StartPos = $Player2.get_child(0).position

var p1Score = 0
var p2Score = 0
var maxScore = 11

# Called when the node enters the scene tree for the first time.
func _ready():
	_startRound()

func _startRound():
	
	#Reset ball and paddles
	$Ball.position = ballStartPos
	$Player1.get_child(0).position = paddle1StartPos
	$Player2.get_child(0).position = paddle2StartPos

	#Check for game over
	if (p1Score >= maxScore):
		gameOver(true)
		return
	elif (p2Score >= maxScore):
		gameOver(false)
		return
	

	#serve in random direction	
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var randDir = rng.randi_range(1,2)
	if(randDir == 2): #Jeez this is painful to look at
		randDir = -1
	
	$Ball.serve(randDir)
	
	#Adjust difficulty

func adjustDifficulty():
	var scoreDifference = p1Score - p2Score
	#negative, then losing, so easier
	#.5 is a level of difficulty jump. 
	#EXE: 3.5 default, ai leads by 4 points, becomes easy
	#Only want to change when big gap
	if abs(scoreDifference) >= 3:
		$Player2.speed += scoreDifference * .1
	

func gameOver(won):
	$Ball.queue_free()
	$Player1.queue_free()
	$Player2.queue_free()
	
	var button = get_node("Control/GameOverUI/StartButton")
	button.connect("pressed", self, "restart_button_pressed")
	button.show()
	
	if won:
		var winLabel = get_node("Control/GameOverUI/Win")
		winLabel.show()
	else:
		var loseLabel = get_node("Control/GameOverUI/Lose")
		loseLabel.show()


func restart_button_pressed():
	print("Start Button Pressed")
	get_tree().change_scene("res://Scenes/PlayScene.tscn")


	
	
func _p1Scored():
	p1Score += 1
	$Control/P1ScoreLabel.text = str(p1Score)
	_startRound()
	
func _p2Scored():
	p2Score += 1
	$Control/P2ScoreLabel.text = str(p2Score)
	_startRound()
