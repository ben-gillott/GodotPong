extends KinematicBody2D


var velocity = Vector2.ZERO
var baseSpeed = 400
onready var currentSpeed = baseSpeed
var speedupPerSecond = 15 #per second
var speedupPerPlayerScore = 10
var roundTime = 0
 
var randomness = .4
var serveRandomness = .7
var waitTime = .0

func _ready():
	serve(1)

func serve(xDir):
	currentSpeed = baseSpeed
	roundTime = 0
	velocity = Vector2.ZERO
	
	var yDir = rand_range(serveRandomness, -serveRandomness)
	var direction = Vector2(xDir, yDir)
	velocity = direction * currentSpeed

func _physics_process(delta):
	var direction = velocity.normalized()
	var col = move_and_collide(velocity * delta)
	
	if col != null: 
		#playsound
		_hitFX()
		
		#Bounce
		var randomDiff = Vector2(0, rand_range(randomness, -randomness))
		direction = direction.bounce(col.normal) + randomDiff
		velocity = direction * currentSpeed
	
func _hitFX():
	#$HitAudio.play()
	$HitParticles.emitting = true
