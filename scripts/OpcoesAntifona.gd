extends OptionButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("item_selected", self, '_perder_foco')
	connect("modal_closed", self, '_perder_foco')

func _perder_foco(variavel=0):
	release_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
