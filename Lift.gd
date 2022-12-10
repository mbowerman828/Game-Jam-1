extends KinematicBody2D

var speed = 200  
var velocity = Vector2.ZERO

func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed("Move_Lift_Right"):
		velocity.x += 1
	if Input.is_action_pressed("Move_Lift_Left"):
		velocity.x -= 1
	if Input.is_action_pressed("Move_Lift_Down"):
		velocity.y += 1
	if Input.is_action_pressed("Move_Lift_Up"):
		velocity.y -= 1
		print("Up Works Dumbass", velocity.y)
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)