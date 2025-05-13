extends Control

@onready var app: Control = $".."

@onready var main_display: Control = $"../Main_Display"
@onready var data_entry_menu: Control = $"."

@onready var data_name: Label = $VBoxContainer/Name
@onready var data_amount: Label = $VBoxContainer/Amount

var key_number

func setup(_name:String, _data_amount:float, _key_number:String):
	data_name.text = _name
	data_amount.text = "$" + str(snapped(_data_amount, 0.01))
	key_number = _key_number

func _on_delete_pressed() -> void:
	app.remove_data_element(key_number)
	data_entry_menu.visible = false
	main_display.visible = true
	app.reformat_entries()

func _on_cancel_pressed() -> void:
	data_entry_menu.visible = false
	main_display.visible = true
