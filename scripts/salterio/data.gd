extends Node

class_name Data

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var data_godot:Dictionary
var dia:int

# Called when the node enters the scene tree for the first time.
func _ready():
	da_data(OS.get_date())
	
func da_data(data:Dictionary):
	self.data_godot = data
	var bissexto = false
	if data_godot['year'] % 4 == 0: # Dura até 2099
		bissexto = true
	dia = (data['month']-1) * 30 + data['day']
	if data['month'] == 2:
		dia += 1
	elif data['month'] >= 3 and bissexto:
		dia -= 1
	elif data['month'] >3 and !bissexto:
		dia -= 2
	if data['month'] > 2 and data['month'] <= 8:
		dia += int(data['month']) / 2
	elif data['month'] > 8:
		dia += 5 + int(data['month']-9) / 2

func do_dia_ano(ndia:int, ano:int): #TODO
	if ndia <= 31:
		data_godot = {'year': ano, 'month': 1, 'day': ndia}
		return
	var bissexto = false
	if data_godot['year'] % 4 == 0: # Dura até 2099
		bissexto = true
	if (bissexto and ndia <=60) or (!bissexto and ndia <=59):
		data_godot = {'year': ano, 'month': 2, 'day': ndia - 31}
	return
	

func festas_moveis():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
