extends OptionButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


	

# Called when the node enters the scene tree for the first time.
func _ready():
	add_item('I Vésperas', Globais.Hora.I_VESPERAS)
	add_item('Completas após I Vésperas', Globais.Hora.I_COMPLETAS)
	add_item('Leituras', Globais.Hora.LEITURAS)
	add_item('Laudes', Globais.Hora.LAUDES)
	add_item('Média (Sexta)', Globais.Hora.MEDIA)
	add_item('Vésperas', Globais.Hora.VESPERAS)
	add_item('Completas', Globais.Hora.COMPLETAS)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
