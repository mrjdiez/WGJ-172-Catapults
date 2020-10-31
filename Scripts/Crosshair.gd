extends Node2D

export var tension_limit = 50

onready var parent_center = get_node("..").global_position

# Called when the node enters the scene tree for the first time.
func _ready():
	self._update_connector()


func _process(delta):
	if self.visible:
		var mouse = get_viewport().get_mouse_position()
		self._update_position(mouse)
		self._update_connector()
	
func _update_position(mouse_position):
	self.global_position = self._get_crosshair_position(mouse_position)
	
func _update_connector():
	var origin_position = self.global_position - self.parent_center
	$Connector.points = PoolVector2Array([-origin_position, Vector2(0,0)])

func _get_crosshair_position(mouse_position):
	var distance = self.parent_center.distance_to(mouse_position)
	if distance <= self.tension_limit:
		return mouse_position
	else:
		var offset_position = Vector2(self.tension_limit, self.tension_limit) * self.parent_center.direction_to(mouse_position)
		return self.parent_center + offset_position

func hide():
	self.visible = false

func show():
	self.visible = true
