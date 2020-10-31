extends KinematicBody2D

export var speed = 100

var travel = false
var coords = null

func _process(delta):
	if self.travel:
		var next_step = self.global_position.move_toward(self.coords, (delta*self.speed))
		if next_step == self.global_position:
			self.hit()
		else:
			self.global_position = next_step

func travel_to(target_coords):
	self.travel = true
	self.coords = target_coords

func _destroy():
	self.queue_free()

func hit():
	print("Hit?")
	$Polygon2D.visible = false
	$CollisionShape2D.disabled = true
	self.travel = false
	$AnimationPlayer.play("Explosión")
