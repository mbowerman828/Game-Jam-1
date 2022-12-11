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


var velocity : Vector2 = Vector2()


onready var sprite : Sprite = get_node("Sprite")

func _getInput():

	velocity = Vector2.ZERO

	if Input.is_action_just_pressed("Wipe"):
		do_clean_attempt()
	else:
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
			$AnimatedSprite.play("WalkingRight")
			if relativePos < maxRelativePos:
				velocity.x += speed
				relativePos += speed


		if Input.is_action_pressed("Move_Character_Left"):
			$AnimatedSprite.play("WalkingLeft")
			if relativePos > (maxRelativePos * -1):
				velocity.x -= speed
				relativePos -= speed
				
		if Input.is_action_just_released("Move_Character_Left"):
			$AnimatedSprite.play("Idle")
		if Input.is_action_just_released("Move_Character_Right"):
			$AnimatedSprite.play("Idle")


func do_clean_attempt():
	var overlappingArray = $WipeArea.get_overlapping_areas()
	if overlappingArray.size() > 0:
		overlappingArray.front().set_to_clean()
	else:
		print("Add failed to clean animation maybe")


func _physics_process(delta):
	_getInput()
	velocity = move_and_slide(velocity, Vector2.UP)

