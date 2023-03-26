extends OptionButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	add_item('Domingo', Globais.DiaDaSemana.DOMINGO)
	add_item('Segunda-Feira', Globais.DiaDaSemana.SEGUNDA)
	add_item('Terça-Feira', Globais.DiaDaSemana.TERCA)
	add_item('Quarta-Feira', Globais.DiaDaSemana.QUARTA)
	add_item('Quinta-Feira', Globais.DiaDaSemana.QUINTA)
	add_item('Sexta-Feira', Globais.DiaDaSemana.SEXTA)
	add_item('Sábado', Globais.DiaDaSemana.SABADO)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
