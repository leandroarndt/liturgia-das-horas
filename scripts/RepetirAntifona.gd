extends CheckButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pressed = Globais.repetir_antifona
	connect("toggled", self, '_on_RepetirAntifona_toggled')

func _on_RepetirAntifona_toggled(button_pressed):
	release_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
