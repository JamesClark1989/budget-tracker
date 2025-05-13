extends Control

@onready var app: Control = $".."

@onready var delete_menu: Control = $"."
@onready var main_display: Control = $"../Main_Display"

func _on_no_pressed() -> void:
	delete_menu.visible = false
	main_display.visible = true


func _on_yes_pressed() -> void:
	app.remove_all_data()
	delete_menu.visible = false
	main_display.visible = true
	app.populate_data_container()
