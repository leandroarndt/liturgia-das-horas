extends Resource

class_name Salterio

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (Globais.Tempo) var tempo
export (Globais.TipoCelebracao) var tipo = Globais.TipoCelebracao.COMUM
export (int) var semana
export (String) var nome
export (Array,Resource) var celebracoes

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func buscar(hora, dia_da_semana, mes, dia, nome):
	for celebracao in celebracoes:
		if celebracao.hora == hora \
		and celebracao.dia_da_semana == dia_da_semana \
		and celebracao.mes == mes \
		and celebracao.dia == dia:
			return celebracao
	# Procurar na semana adequada

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
