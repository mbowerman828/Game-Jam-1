extends KinematicBody2D


var velocity : Vector2 = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	velocity = move_and_slide(velocity)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
