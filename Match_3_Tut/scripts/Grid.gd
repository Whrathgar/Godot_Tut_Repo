extends Node2D

# Grid varibles
export (int) var width;
export (int) var height;
export (int) var x_start;
export (int) var y_start;
export (int) var offset;


var possible_pieces = [
	preload("res://scenes/YellowPiece.tscn"),
	preload("res://scenes/GreenPiece.tscn"),
	preload("res://scenes/OrangePiece.tscn"),
	preload("res://scenes/PinkPiece.tscn"),
	preload("res://scenes/BluePiece.tscn"),
	preload("res://scenes/LightGreenPiece.tscn")
];

#the currect pieces on screen
var all_pieces = [];

#Touch variables
var first_touch = Vector2(0,0);
var final_touch = Vector2(0,0);

func _ready():
	randomize()
	all_pieces = make_2d_array();
	spawn_pieces();

func make_2d_array():
	var array = [];
	for i in width:
			array.append([]);
			for j in height:
					array[i].append(null);
	return array;

func spawn_pieces():
	for i in width:
		for j in height:
			#choose and randoom number and store it
			var rand = floor(rand_range(0, possible_pieces.size()));
			#Instance that piece from the array
			var piece = possible_pieces[rand].instance();
			add_child(piece);
			piece.position = grid_to_pixel(i,j)


func grid_to_pixel(column,row):
	var new_x = x_start + offset * column;
	var new_y = y_start + -offset * row;
	return Vector2(new_x, new_y);
	pass;

func pixel_to_grid(pixel_x,pixel_y):
	var new_x = round((pixel_x - x_start) / offset);
	var new_y = round((pixel_y - y_start) / -offset);
	return Vector2(new_x,new_y)
	pass;

func touch_input():
	if Input.is_action_just_pressed("ui_touch"):
		first_touch = get_global_mouse_position();
		var grid_position = pixel_to_grid(first_touch.x,first_touch.y);
		print(grid_position);
	if Input.is_action_just_released("ui_touch"):
		final_touch = get_global_mouse_position();
		#var grid_position = pixel_to_grid(final_touch.x,final_touch.y)



func _process(delta):
	touch_input()
