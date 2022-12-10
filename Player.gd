extends KinematicBody2D



var score : int = 0

var speed : int = 200

var gravityForce : int = 800

var velocity : Vector2 = Vector2()


onready var sprite : Sprite = get_node("Sprite")

func _getInput():
	velocity.x = 0
	
	#move left and right
	if Input.is_action_pressed("Move_Character_Right"):
		velocity.x += speed
	if Input.is_action_pressed("Move_Character_Left"):
		velocity.x -= speed
		
	
	
	
	#makes the sprite turn
	if velocity.x < 0:
		sprite.flip_h = true
	elif velocity.x > 0:
		sprite.flip_h = false

func _physics_process(delta):
	_getInput()
	velocity = move_and_slide(velocity, Vector2.UP)
	
	#gravity
	velocity.y += gravityForce * delta
	
	
	
