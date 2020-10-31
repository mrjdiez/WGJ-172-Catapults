extends Node

export var target_min_point = Vector2(50, 50)
export var target_max_point = Vector2(350, 350)
export var target_limit = 5
export var obstacle_limit = 2

var Target = preload("res://Objects/Target.tscn")
var Obstacle = preload("res://Objects/Obstacle.tscn")

var _score: int = 0

func _ready():
	self.create_target()

func _process(delta):
	$TimerLabel.text = str(int($EndGameTimer.time_left))

func _on_Timer_timeout():
	self.create_target()

func _target_hitted(score):
	self._score += score
	$ScoreLabel.text = str(self._score)
	if score > 0:
		$AnimationPlayer.play("ScoreUp")
	else:
		$AnimationPlayer.play("ScoreDown")

func _new_coords():
	randomize()
	var _new_x = floor(rand_range(self.target_max_point.x, self.target_min_point.x))
	var _new_y = floor(rand_range(self.target_max_point.y, self.target_min_point.y))
	return Vector2(_new_x, _new_y)

func _new_target():
	return self._target_factory(Target)

func _new_obstacle():
	return self._target_factory(Obstacle)

func _target_factory(TargetKind):
	var _target = TargetKind.instance()
	_target.global_position = self._new_coords()
	return _target

func create_target():
	var targets = $Targets.get_children()
	if targets.size() == self.target_limit:
		return 
	var obstacles = []
	for target in targets:
		if target.has_method('_toggle_move'):
			obstacles.append(target)
	var _t = null
	if obstacles.size() == self.obstacle_limit or randi() % 2 == 0:
		_t = self._new_target()
	else:
		_t = self._new_obstacle()
	$Targets.add_child(_t)
	_t.connect('target_hitted', self, '_target_hitted')


func _on_EndGameTimer_timeout():
	$EndGameLabel.visible = true
	$TextureButton.visible = true
	$NewTargetTimer.stop()
	get_tree().call_group("actors", "end_game")
	$AnimationPlayer.play("EndGame")
	
func _on_TextureButton_pressed():
	get_tree().change_scene("res://Root.tscn")
