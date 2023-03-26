extends Resource

class_name Colecao

enum Tipo {SALTERIOS, ORDINARIOS}

export(Tipo) var tipo
export(Array,Resource) var objetos
export(String) var nome

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#hora, dia_da_semana, 0, 0, ''
func buscar_celebracao(hora:int, tempo:int, semana:int, dia_da_semana:int):
	var celebracao:Celebracao
	for obj in objetos:
#			and obj.semana == semana \
		if obj is Salterio \
		and obj.tempo == tempo \
		and obj.tipo > Globais.TipoCelebracao.ORDINARIO \
		and obj.semana == semana:
			for c in obj.celebracoes:
#		if obj is Celebracao:
				if c.hora == hora \
				and c.tipo != Globais.TipoCelebracao.ORDINARIO \
				and c.tempo == tempo \
				and c.dia_da_semana == dia_da_semana:
					return c
#		elif obj is Salterio:
#			for c in obj.celebracoes:
#				if c.hora == hora \
#				and c.tipo != Globais.TipoCelebracao.ORDINARIO \
#				and c.tempo == tempo \
#				and c.semana == semana \
#				and c.dia == dia:
#					return c
		else:
			if obj.has_method('buscar_celebracao'):
				celebracao = obj.buscar_celebracao(hora, tempo, semana, dia_da_semana)
			if celebracao is Celebracao:
				return celebracao
	return celebracao

func buscar_ordinario(hora:int, tempo:int=Globais.Tempo.COMUM) -> Celebracao:
	var ordinario:Celebracao
	for obj in objetos:
		if obj is Celebracao:
			if obj.hora == hora \
			and obj.tipo == Globais.TipoCelebracao.ORDINARIO \
			and obj.tempo == tempo:
				return obj
		elif obj is Salterio:
			for celebracao in obj.celebracoes:
				if celebracao.hora == hora \
				and celebracao.tipo == Globais.TipoCelebracao.ORDINARIO \
				and celebracao.tempo == tempo:
					return celebracao
		else:
			ordinario = obj.buscar_ordinario(hora, tempo)
			if ordinario is Celebracao:
				return ordinario
	return ordinario

func listar_festas() -> Array:
#	var retorno:Dictionary = {
#		0: [],
#		1: [],
#		2: [],
#		3: [],
#		4: [],
#		5: [],
#		6: [],
#		7: [],
#		8: [],
#		9: [],
#		10: [],
#		11: [],
#		12: [],
#	}
	var retorno:Array = []
	for obj in objetos:
#		if obj is Celebracao:
#			if obj.tipo >= Globais.TipoCelebracao.MEMORIA_FACULTATIVA:
#				retorno.append(obj)
#		elif obj is Salterio:
#			for celebracao in obj.celebracoes:
#				if celebracao.tipo >= Globais.TipoCelebracao.MEMORIA_FACULTATIVA:
#					retorno.append(celebracao)

		if obj is Salterio:
			if obj.tipo >= Globais.TipoCelebracao.MEMORIA_FACULTATIVA:
				retorno += obj
		elif obj.has_method('listar_festas'):
			retorno += obj.listar_festas()
#			var festas = obj.buscar_festas()
#			for n in festas.keys():
#				retorno[n].append(festas[n])
	return retorno
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
