extends "res://Scripts/Target.gd"

export var distance: int = 100

onready var start = global_position
onready var end = null

func _ready():
	._ready()
	self.score = -self.score
	randomize()
	var x_offset = randf() * self.distance
	var y_offset = randf() * self.distance
	var x_sign = 1 if randi() % 2 == 1 else -1
	var y_sign = 1 if randi() % 2 == 1 else -1
	self.end = self.start + Vector2(x_offset * x_sign, y_offset * y_sign)
	

func _toggle_move():
	var t = self.start
	self.start = self.end
	self.end = t

func _on_Timer_timeout():
	$MoveTween.interpolate_property(self, 'global_position', self.start, self.end, 2)
	$MoveTween.start()
	self._toggle_move()
