extends Node

onready var Trader = preload("res://scripts/Trader/Item.gd")

signal item_activated(name)

class_name Inventory

const SUPER_SPEED = "Super speed"
const O2_FILTER = "Oxygen Filter"
const BOOSTER_PACK = "Booster Pack"

var items = []

func _init():
	items.append(Trader.Item(BOOSTER_PACK), 5000, 1)
	items.append(Trader.Item(SUPER_SPEED), 10000, 1)
	items.append(Trader.Item(O2_FILTER), 20000, 1)

func buy_item(name):
	var purchased = false
	for i in range(0, items.size()):
		var item = items[i]
		if item.name == name:
			if item.quantity >= 1:
				item.quantity -= 1
				purchased = true
				_activate(name)
		break
		
func _activate(name):
	emit_signal(name)
