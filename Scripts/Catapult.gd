extends Area2D


var click = false

onready var Rock = preload("res://Objects/Rock.tscn")


func _process(delta):
	if self.click:
		if not Input.is_mouse_button_pressed(1):
			self.click = false
			get_tree().call_group('crosshair', 'hide')
			$AnimatedSprite.stop()
			$AnimatedSprite.frame = 0
			$AnimatedSprite.play("throw")
			$Timer.start()
			

func _on_Catapult_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		get_tree().call_group('crosshair', 'show')
		self.click = true

func end_game():
	$CollisionShape2D.disabled = true
	self.click = false
	get_tree().call_group('crosshair', 'hide')

func start_game():
	$CollisionShape2D.disabled = true



func _on_Timer_timeout():
	var travel_to = $TargetCrosshair.global_position
	var rock = Rock.instance()
	rock.global_position = $RockStart.global_position
	get_parent().add_child(rock)
	rock.travel_to(travel_to)
