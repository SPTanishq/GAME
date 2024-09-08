class_name Field
extends MarginContainer

signal cardMoved
signal power_changed

@onready var card_drop_area_right: Area2D = $CardDropAreaRight
@onready var card_drop_area_left: Area2D = $CardDropAreaLeft
@onready var cards_holder: HBoxContainer = $CardsHolder
var power = 0
var HF = false

var cardList = {}

func _ready():
	$Label.text = name
	
	if cards_holder.get_child_count() > Global.MAX_CARDS:
		HF = true
		power = 21
	
	for child in cards_holder.get_children():
		var card := child as Card
		card.home_field = self


func return_card_starting_position(card: Card):
	card.reparent(cards_holder)
	cards_holder.move_child(card, card.index)


func set_new_card(card):
		cardMoved.emit(card)
		card_reposition(card)
		card.home_field = self
		if !HF:
			power += Global.itemData[card.type]["p"]
			power_changed.emit(power)
			cardList[card.type] = card
		else:
			power = 0

func _on_card_moved(card):
	if card.home_field == self:
		print(str(card.home_field) + " " + str(self))
		power -= Global.itemData[card.type]["p"]
		power_changed.emit(power)
		cardList.erase(card.type)

func card_reposition(card: Card):
	var field_areas = card.drop_point_detector.get_overlapping_areas()
	var cards_areas = card.card_detector.get_overlapping_areas()
	var index: int = 0
	
	if cards_areas.is_empty():
		print(field_areas.has(card_drop_area_left))
		if field_areas.has(card_drop_area_right):
			index = cards_holder.get_children().size()
	elif cards_areas.size() == 1:
		if field_areas.has(card_drop_area_left):
			index = cards_areas[0].get_parent().get_index()
		else:
			index = cards_areas[0].get_parent().get_index() + 1
	else:
		index = cards_areas[0].get_parent().get_index()
		if index > cards_areas[1].get_parent().get_index():
			index = cards_areas[1].get_parent().get_index()
		
		index += 1

	card.reparent(cards_holder)
	cards_holder.move_child(card, index)

#Debug can delete
func _on_timer_timeout():
	print(str(power) + " " + str(name))
