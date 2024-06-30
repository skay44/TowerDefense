extends Node3D

@export var rayLength: float
@export var tower: PackedScene

var vSize: Vector2
var viewport: Viewport
var selectedTile: Vector2i

# Called when the node enters the scene tree for the first time.
func _ready():
	viewport = get_viewport()
	vSize = viewport.get_size()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	processMouse()
	if Input.is_action_just_pressed("select"):
		var towerInstance = tower.instantiate()
		towerInstance.position = Vector3(selectedTile.x*2,0,selectedTile.y*2)
		add_child(towerInstance)
	
	
func processMouse():
	var cam = viewport.get_camera_3d()
	var camPos = cam.transform.origin
	var camRot = cam.get_quaternion()
	var camSize = cam.size
	var onScreenPosition = viewport.get_mouse_position()
	var mousePosition = (onScreenPosition - vSize/2) / Vector2(vSize.x,vSize.y) * Vector2(camSize/vSize.y*vSize.x,camSize)
	mousePosition *= Vector2(1,-1)
	
	var rayStart = camPos + camRot * Vector3(mousePosition.x,mousePosition.y,0)
	var rayEnd = camPos + camRot * Vector3(mousePosition.x,mousePosition.y,-rayLength)
	
	var query = PhysicsRayQueryParameters3D.create(rayStart, rayEnd)
	query.collide_with_areas = true
	
	var space_state = get_world_3d().direct_space_state
	var result = space_state.intersect_ray(query)
	
	if(result.size() > 0):
		var pos = result["position"]
		pos = Vector3(round(pos.x/2)*2,0,round(pos.z/2)*2)
		$SelectedTile.position = pos
		var oldSelected = selectedTile
		selectedTile = Vector2(round(pos.x/2),round(pos.z/2));
		if oldSelected != selectedTile:
			print(selectedTile)
	
	#print(rayStart)
	#print(rayEnd)
	#print(result.size())
	
	pass
	
