extends Control

@onready var main_display: Control = $Main_Display
@onready var entry_display: Control = $Entry_Display
@onready var delete_menu: Control = $Delete_Menu
@onready var data_entry_menu: Control = $Data_Entry_Menu

const DATA_ENTRY_BUTTON = preload("res://data_entry_button.tscn")
@onready var data_v_box_container: VBoxContainer = $Main_Display/VBoxContainer/ScrollContainer/DataVBoxContainer
var entries = {}

@onready var total_price_label: Label = $Main_Display/VBoxContainer/TotalPriceLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	entries = load_entries()
	await get_tree().process_frame
	populate_data_container()

func remove_all_data():
	var path = OS.get_user_data_dir() + "/entries.json"
	var dir = DirAccess.open(OS.get_user_data_dir())
	if dir and dir.file_exists(path):
		var result = dir.remove(path)
		if result == OK:
			print("File deleted successfully.")
		else:
			print("Failed to delete file.")
	else:
		print("File does not exist.")
	entries = {}

func add_to_entries(name:String, amount:float):
	var new_entries = {}
	new_entries["0"] = {"name":name,"amount":amount}
	
	if entries.size() > 0:
		var index : int = 1
		for key in entries.keys():
			var entry = entries[key]
			new_entries[str(index)] = {"name":entry["name"],"amount":entry["amount"]}
			index += 1
	
	entries = new_entries
	
	save_entry(entries)
	populate_data_container()

func reformat_entries():
	remove_all_data_buttons()
	var new_entries = {}
	if entries.size() > 0:
		var index : int = 0
		for key in entries.keys():
			var entry = entries[key]
			new_entries[str(index)] = {"name":entry["name"],"amount":entry["amount"]}
			index += 1
	
	entries = new_entries
	
	save_entry(entries)
	populate_data_container()

func save_entry(_entries : Dictionary):
	var path = OS.get_user_data_dir() + "/entries.json"
	var file = FileAccess.open(path, FileAccess.WRITE)
	
	if file:
		file.store_string(JSON.stringify(entries))

func load_entries():
	var path = OS.get_user_data_dir() + "/entries.json"
	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		if file:
			return JSON.parse_string(file.get_as_text()) as Dictionary
	return {}

func remove_all_data_buttons():
	for child in data_v_box_container.get_children():
		child.queue_free()

func populate_data_container():	
	remove_all_data_buttons()
	total_price_label.text = str("$" + str(0))
	if entries.size() > 0:
		var total_amount : float = 0
		
		for key in entries.keys():
			var entry = entries[key]
			
			var _name = entry["name"]
			var _amount = entry["amount"]
			var _key = str(key)
			
			total_amount += float(_amount)
			
			var data_button = DATA_ENTRY_BUTTON.instantiate()
			data_button.setup_data(_name,_amount,_key,self)
			data_v_box_container.add_child(data_button)
		total_price_label.text = str("$" + str(snapped(total_amount, 0.01)))

func _on_create_new_button_pressed() -> void:
	main_display.visible = false
	entry_display.visible = true


func _on_delete_data_button_pressed() -> void:
	main_display.visible = false
	delete_menu.visible = true

func remove_data_element(key:String):
	print(entries)
	print("Deleting key:" + key)
	entries.erase(key)
	print(entries)

func show_data_entry_menu(_name:String,_amount:float,key:String):
	main_display.visible = false
	data_entry_menu.visible = true
	data_entry_menu.setup(_name,_amount,key)
