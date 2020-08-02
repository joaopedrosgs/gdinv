# Copyright (c) 2019-2020 ZCaliptium.
extends Node

# Fields.

const PluginSettings = preload("GDInv_Settings.gd");
var REGISTRY: Dictionary = {};

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var isLoadOnReady: bool = PluginSettings.get_option(PluginSettings.PROP_LOADONREADY);
	
	if (isLoadOnReady):
		load_data();

# Loads all item definitions from specified paths.
func load_data() -> void:
	var paths: Array = PluginSettings.get_option(PluginSettings.PROP_PATHS);
	
	print("[gdinv] Item JSON directories count... ", paths.size());

	# Iterate through array.
	for i in range(0, paths.size()):
		var path: String = paths[i];
		
		if (!path.empty()):
			print("  [", i, "] - ", path);
			load_items_from_dir(path);
		else:
			print("  [", i, "] - Empty");

# Tries to load JSON files from specified directory.
func load_items_from_dir(path: String) -> void:

	var dir = Directory.new();
	
	# If directory exist.
	if (dir.open(path) == OK):
		dir.list_dir_begin(true);
		var file_name = dir.get_next();
		
		# Until we have entries...
		while (file_name != ""):
			if (!dir.current_is_dir() && file_name.ends_with(".json")):
				print("    ", file_name);
				load_item(path + file_name);
			file_name = dir.get_next();
		
		print("    End");
	
func load_item(url: String) -> void:
	var item = load(url) # Load resource file
	REGISTRY[item.name] = item;

	
# Makes new stack instance and returns reference to it, otherwise returns null.
func make_stack_by_id(item_id: String, count: int = 1) -> GDInv_ItemStack:
	if (item_id == null):
		return null;
	
	# Get item definition.
	var item_def: GDInv_ItemResource = REGISTRY.get(item_id);
	if (item_def == null):
		return null;
		
	var new_stack = GDInv_ItemStack.new(item_def, count);
	return new_stack;

# Getter by key for definition registry.
func get_item_by_id(item_id: String) -> GDInv_ItemResource:
	return REGISTRY.get(item_id);
