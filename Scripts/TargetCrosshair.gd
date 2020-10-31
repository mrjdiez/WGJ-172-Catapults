extends "res://Scripts/Crosshair.gd"

export var multiplier = 2
export var target_found_color = "#55ff00"

func _update_position(mouse_position):
	var crosshair_position = self._get_crosshair_position(mouse_position)
	self.global_position = self.parent_center - ((crosshair_position - self.parent_center) * self.multiplier)


func _on_Area2D_area_entered(area):
	$Sprite.modulate = self.target_found_color

func _on_Area2D_area_exited(area):
	$Sprite.modulate = "#ffffff"
