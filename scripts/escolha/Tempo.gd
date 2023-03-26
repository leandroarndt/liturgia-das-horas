extends OptionButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	add_item('Tempo comum', Globais.Tempo.COMUM)
	add_item('Advento', Globais.Tempo.ADVENTO)
	add_item('De 17 a 24 de dezembro', Globais.Tempo.DE_17_A_24_DEZ)
	add_item('Oitava do Natal', Globais.Tempo.OITAVA_NATAL)
	add_item('Natal', Globais.Tempo.NATAL)
	add_item('A partir de Quarta-Feira de Cinzas', Globais.Tempo.CINZAS)
	add_item('Quaresma', Globais.Tempo.QUARESMA)
	add_item('Semana Santa', Globais.Tempo.SEMANA_SANTA)
	add_item('Oitava da Páscoa', Globais.Tempo.OITAVA_PASCOA)
	add_item('Páscoa', Globais.Tempo.PASCOA)
	
	select(Globais.Tempo.COMUM)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
