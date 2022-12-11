extends KinematicBody2D

var speed = 200
var velocity = Vector2.ZERO

var staticHorizontalPos: float = 0

var staticVerticalPos : float = 0

var maxHorizontalPosition : float= 22000

var minHorizontalPosition : float = -20000

var maxVerticalPosition : float = 11000

var minVerticalPosition : float = -20000

onready var LiftSound = $LiftSound

func get_input():
	velocity = Vector2.ZERO
	
	if Input.is_action_just_pressed("Wipe"):
		pass
	else:
		if Input.is_action_pressed("Move_Lift_Right"):
			if staticHorizontalPos < maxHorizontalPosition:
				velocity.x += speed
				staticHorizontalPos += speed
				
				
			
		if Input.is_action_pressed("Move_Lift_Left"):
			if staticHorizontalPos > minHorizontalPosition:
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
	

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	
