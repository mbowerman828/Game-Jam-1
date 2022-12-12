extends Node2D

export(PackedScene) var floorObject

var floorSpeed

# Called when the node enters the scene tree for the first time.
func _ready():
		$WipermanLoop.play() 
		floorSpeed = 15
		summonFloor(517,528)
		summonFloor(517,384)
		summonFloor(517,240)
		summonFloor(517,96)
		summonFloor(517,-48)
		$FloorCreationTimer.start()
		

func _on_FloorCreationTimer_timeout():
	summonFloor(517,-48)

func summonFloor(startingX: int, startingY: int):
	
	var floorToSummon = floorObject.instance()
	
	floorToSummon.position.x = startingX
	floorToSummon.position.y = startingY
	
	floorToSummon.velocity.y = floorSpeed
	
	floorToSummon.z_index = 2
	
	add_child(floorToSummon)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



