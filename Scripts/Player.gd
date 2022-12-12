extends KinematicBody2D



var score : int = 0

export var liftSpeed : int = 200
export var speed : int = 200

var relativePos : float = 0

var maxRelativePos : float = 5000

var staticHorizontalPos: float = 0

var staticVerticalPos : float = 0

var maxHorizontalPosition : float= 22000

var minHorizontalPosition : float = -20000

var maxVerticalPosition : float = 11000

var minVerticalPosition : float = -20000

var currentlyCleaning

var velocity : Vector2 = Vector2()

var recievedWindowDirtyness

var accumulatedCleanliness

func _ready():
	$AnimatedSprite.play("Idle")
	z_index = 1000
	currentlyCleaning = false
	accumulatedCleanliness = 0 

func _getInput():

	velocity = Vector2.ZERO

	if Input.is_action_just_pressed("Wipe"):
		currentlyCleaning = true
		do_clean_attempt()
		
	else:
		#Duplicate lift movement to player so they move together

		if Input.is_action_pressed("Move_Lift_Right"):
			if staticHorizontalPos < maxHorizontalPosition:
				velocity.x += liftSpeed
				staticHorizontalPos += liftSpeed
			
		if Input.is_action_pressed("Move_Lift_Left"):
			if staticHorizontalPos> minHorizontalPosition:
				velocity.x -= liftSpeed
				staticHorizontalPos -= liftSpeed
			
			
		if Input.is_action_pressed("Move_Lift_Down"):
			if staticVerticalPos < maxVerticalPosition:
				velocity.y += liftSpeed
				staticVerticalPos += liftSpeed
			
		if Input.is_action_pressed("Move_Lift_Up"):
			if staticVerticalPos > minVerticalPosition:
				velocity.y -= liftSpeed
				staticVerticalPos -= liftSpeed

		


		# Add player specific left-right movement to allow player to move relative to the lift
		if not currentlyCleaning:
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
		if overlappingArray.front().getDirtyness() == 1:
			accumulatedCleanliness += 1
		overlappingArray.front().set_to_clean()
		$AnimatedSprite.play("Wiping")
	else:
		print("Add failed to clean animation maybe")


func _physics_process(delta):
	_getInput()
	velocity = move_and_slide(velocity, Vector2.UP)

func getAcumulatedCleanliness():
	return accumulatedCleanliness




func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.play("Idle")
	currentlyCleaning = false

