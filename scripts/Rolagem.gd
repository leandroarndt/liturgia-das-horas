extends ScrollContainer

export var delay = 200
var target_x = 0
var target_y = 0
var start_x = 0
var start_y = 0
var scroll_start = 0
var delta_time = 0
var scrolling = false
var auto_scrolling = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func scroll_to(x, y):
	print('Atual: ', scroll_vertical)
	print('Alvo y: ', y)
	print('Diferença: ', get_child(0).rect_size.y - rect_size.y)
	if x > get_child(0).rect_size.x - get_viewport().size.x:
		target_x = get_child(0).rect_size.x - get_viewport().size.x
	else:
		target_x = x
	if target_x < 0:
		target_x = 0
	if y > get_child(0).rect_size.y - rect_size.y:
		target_y = get_child(0).rect_size.y - rect_size.y
	else:
		target_y = y
	if target_y < 0:
		target_y = 0
	print('Alvo computado: ', target_y)
	start_x = scroll_horizontal
	start_y = scroll_vertical
	scroll_start = OS.get_system_time_msecs()
	auto_scrolling = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if scrolling or !auto_scrolling:
		return
	delta_time = (OS.get_system_time_msecs() - scroll_start)
	if target_x != scroll_horizontal:
		if (float(delta_time) / delay) >= 1:
			scroll_horizontal = target_x
			auto_scrolling = false
		else:
			scroll_horizontal = (target_x - start_x) * (float(delta_time) / delay)
	if target_y != scroll_vertical:
		if (float(delta_time) / delay) >= 1:
			scroll_vertical = target_y
			auto_scrolling = false
		else:
			scroll_vertical = (target_y - start_y) * (float(delta_time) / delay)


func _on_Rolagem_scroll_started():
	scrolling = true


func _on_Rolagem_scroll_ended():
	scrolling = false
