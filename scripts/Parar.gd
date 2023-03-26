extends Button

signal parar
signal continuar

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed", self, '_on_Parar_pressed')
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#func _input(event):
#	if event is InputEventMouseButton and event.is_pressed():
##		breakpoint
#		emit_signal("pressed")
#		get_tree().set_input_as_handled()

func _on_Parar_pressed():
	print(self.text, ' pressionado')
	if self.text == '||':
		emit_signal('parar')
		#self.text = '>'
	else:
		emit_signal('continuar')
		#self.text = '||'
	self.release_focus()
