extends Area2D


var cleanLevel

var cleanStateimage

var cleanImagesLibrary = ["res://Visuals/WindowForGameJame.png","res://Visuals/WindowForGameJame3.png","res://Visuals/WindowForGameJame2.png"]

var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	#use unique gen seed for each program execution
	rng.randomize()
	
	#set a randomized cleanliness level and base window image
	cleanLevel = rng.randi_range(0,3)
	cleanStateimage = cleanImagesLibrary[rng.randi_range(0,cleanImagesLibrary.size()-1)]
	$WindowImage.texture = load(cleanStateimage)
	
	#set dirt image and its oppacity based on the cleanliness level
	$DirtyImage.texture = load("res://Visuals/Dirty Window.png")
	$DirtyImage.self_modulate.a8 = ((cleanLevel/3) * 70) + 185
	
	# hide the filth sprite if the window is in "clean" state
	if cleanLevel == 0:
		$DirtyImage.hide()
	else:
		$DirtyImage.show()


func set_to_clean():
	if cleanLevel == 0:
		print("Window already clean")
	elif cleanLevel == 1:
		$DirtyImage.hide()
		cleanLevel -= 1
	else:
		cleanLevel -=1
		$DirtyImage.self_modulate.a8 = ((cleanLevel/3) * 70) + 185
		print("Add function to show cleaning action")



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
