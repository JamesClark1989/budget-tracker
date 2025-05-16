extends ScrollContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_v_scroll_bar().custom_minimum_size.x = 30
