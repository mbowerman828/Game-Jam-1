extends KinematicBody2D



var score : int = 0

var speed : int = 200

var relativePos : float = 0

var maxRelativePos : float = 5000

var staticHorizontalPos: float = 0

var staticVerticalPos : float = 0

var maxHorizontalPosition : float= 22000

var minHorizontalPosition : float = -20000

var maxVerticalPosition : float = 11000

var minVerticalPosition : float = -20000

var gravityForce : int = 800

var velocity : Vector2 = Vector2()


onready var sprite : Sprite = get_node("Sprite")

func _getInput():

	velocity = Vector2.ZERO

	#Duplicate lift movement to player so they move together

	if Input.is_action_pressed("Move_Lift_Right"):
		if staticHorizontalPos < maxHorizontalPosition:
			velocity.x += speed
			staticHorizontalPos += speed
		
	if Input.is_action_pressed("Move_Lift_Left"):
		if staticHorizontalPos> minHorizontalPosition:
			velocity.x -= speed
			staticHorizontalPos -= speed
		
		
	if Input.is_action_pressed("Move_Lift_Down"):
		if staticVerticalPos < maxVerticalPosition:
			velocity.y += speed
			staticVerticalPos += speed
		
	if Input.is_action_pressed("Move_Lift_Up"):
		if staticVerticalPos > minVerticalPosition:
			velocity.y -= speed
			staticVerticalPos -= speed

	#velocity = velocity.normalized() * speed


	# Add player specific left-right movement to allow player to move relative to the lift

	if Input.is_action_pressed("Move_Character_Right"):
		sprite.flip_h = true
		if relativePos < maxRelativePos:
			velocity.x += speed
			relativePos += speed
			print("RelativePos:", relativePos)


	if Input.is_action_pressed("Move_Character_Left"):
		sprite.flip_h = false
		if relativePos > (maxRelativePos * -1):
			velocity.x -= speed
			relativePos -= speed
			print("RelativePos:", relativePos)


func _physics_process(delta):
	_getInput()
	velocity = move_and_slide(velocity, Vector2.UP)
	
		
	#gravity
	#velocity.y += gravityForce * delta
