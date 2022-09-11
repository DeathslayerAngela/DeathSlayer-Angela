extends Node2D


onready var saveslots = $SaveSlots
var selected_slot_index = 0

signal create_save
signal delete_save

# Called when the node enters the scene tree for the first time.
func _ready():
	saveslots.select(0, true)
	selected_slot_index = 1

func _on_SaveSlots_item_selected(index):
	selected_slot_index = index+1

func _on_Delete_pressed():
	emit_signal("delete_save", selected_slot_index)
	#saveslots.clear_index(selected_slot_index)
	saveslots.update_slot_indices()

func _on_Save_pressed():
	emit_signal("create_save", selected_slot_index)
	saveslots.update_slot_indices()

func _on_Back_pressed():
	self.visible = false
	
