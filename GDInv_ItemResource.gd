# Copyright (c) 2019-2020 ZCaliptium.
extends Resource
class_name GDInv_ItemResource

export var name : String
export var maxStackSize :  int = 1

enum ItemType {GENERIC, CONSUMABLE, QUEST_ITEM, EQUIPTMENT}
export(ItemType) var type

export var texture : Texture
export var mesh : Mesh
export var attributes: Dictionary = {};
	
func get_attribute(key: String, default = null):
	return attributes.get(key, default);

