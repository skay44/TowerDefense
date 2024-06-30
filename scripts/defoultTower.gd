extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_left"):
		$TowerBase/TowerHead.rotate(Vector3.UP, 1*delta)
	if Input.is_action_pressed("ui_right"):
		$TowerBase/TowerHead.rotate(Vector3.UP, -1*delta)
