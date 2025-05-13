extends Button

var app_manager : Control

var data_name : String
var data_amount : float
var key_number : String

func setup_data(_data_name:String, _data_amount:float, _date:String, key:String, _app_manager:Control):
	data_name = _data_name
	data_amount = _data_amount
	$NinePatchRect/HBoxContainer/VBoxContainer/name_label.text = data_name
	$NinePatchRect/HBoxContainer/amount_label.text = str(data_amount)
	$NinePatchRect/HBoxContainer/VBoxContainer/date_label.text = _date

	key_number = key
	app_manager = _app_manager


func _on_pressed() -> void:
	app_manager.show_data_entry_menu(data_name, data_amount, key_number)
