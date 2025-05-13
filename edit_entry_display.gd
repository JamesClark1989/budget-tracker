extends Control

@onready var app: Control = $".."
@onready var error_label: Label = $VBoxContainer/ErrorLabel

@onready var name_line_edit: LineEdit = $VBoxContainer/Entries/NameLineEdit
@onready var amount_line_edit: LineEdit = $VBoxContainer/Entries/Amount
var key_value : String

@onready var main_display: Control = $"../Main_Display"
@onready var edit_entry_display: Control = $"."


func setup(_name:String,_amount:float, _key:String):
	name_line_edit.placeholder_text = _name
	amount_line_edit.placeholder_text = str(_amount)
	key_value = _key



func _on_exit_entry_button_pressed() -> void:
	edit_entry_display.visible = false
	main_display.visible = true


func _on_apply_pressed() -> void:
	if amount_line_edit.text != "" and not amount_line_edit.text.strip_edges().is_valid_float():
		error_label.text = "Please enter a number in amount."
		return
	var new_name = name_line_edit.text if name_line_edit.text != "" else name_line_edit.placeholder_text
	var new_amount = float(amount_line_edit.text) if amount_line_edit.text != "" else float(amount_line_edit.placeholder_text)
	
	app.edit_entry(new_name,new_amount,key_value)
	edit_entry_display.visible = false
	main_display.visible = true
	app.populate_data_container()
