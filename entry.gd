extends Control

@onready var app: Control = $".."

@onready var name_line_edit: LineEdit = $VBoxContainer/Entries/NameLineEdit
@onready var amount: LineEdit = $VBoxContainer/Entries/Amount

@onready var error_label: Label = $VBoxContainer/ErrorLabel

@onready var main_display: Control = $"../Main_Display"
@onready var entry_display: Control = $"."


func clear_text_edits():
	name_line_edit.text = ""
	amount.text = ""

func _on_add_pressed() -> void:
	# Error check name string
	if name_line_edit.text.strip_edges() == "":
		error_label.text = "Please enter a name."
		return
	
	# Error check amount string
	if amount.text.strip_edges() == "":
		error_label.text = "Please enter an amount."
		return
	elif not amount.text.strip_edges().is_valid_float():
			error_label.text = "Please enter a number in amount."
			return
	
	var _name = name_line_edit.text
	var _amount = float(amount.text)
	
	app.add_to_entries(_name,_amount)
	
	entry_display.visible = false
	main_display.visible = true

func _on_visibility_changed() -> void:
	if visible == false:
		clear_text_edits()

func _on_exit_entry_button_pressed() -> void:
	entry_display.visible = false
	main_display.visible = true
