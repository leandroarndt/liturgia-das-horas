extends Node
signal fim_celebracao

class_name Controlador

# Declare member variables here. Examples:

var privilegios_minimos = {
	Globais.Tempo.COMUM: Globais.TipoCelebracao.COMUM,
	Globais.Tempo.ADVENTO: Globais.TipoCelebracao.COMUM,
	Globais.Tempo.DE_17_A_24_DEZ: Globais.TipoCelebracao.FESTA,
	Globais.Tempo.OITAVA_NATAL: Globais.TipoCelebracao.FESTA,
	Globais.Tempo.NATAL: Globais.TipoCelebracao.COMUM,
	Globais.Tempo.CINZAS: Globais.TipoCelebracao.FESTA,
	Globais.Tempo.QUARESMA: Globais.TipoCelebracao.MEMORIA_FACULTATIVA, # As obrigatórias são facultadas (239)
	Globais.Tempo.SEMANA_SANTA: Globais.TipoCelebracao.FESTA,
	Globais.Tempo.OITAVA_PASCOA: Globais.TipoCelebracao.FESTA,
	Globais.Tempo.PASCOA: Globais.TipoCelebracao.COMUM,
}
# Domingo de Páscoa como [dia, mês]
var pascoa = {
	2021: [4, 4],
	2022: [17, 4],
	2023: [9, 4],
	2024: [31, 3],
	2025: [20, 4],
	2026: [5, 4],
	2027: [28, 3],
	2028: [16, 4],
	2029: [1, 4],
	2030: [21, 4],
}

var salterios = {}
var colecao:Colecao
var celebracao:Celebracao
var atual:int = -1

func montar_celebracao(hora:int, tempo:int, semana:int, dia_da_semana:int, festa=null, invitatorio=false):
	#var salterio:Salterio
	var celebracao_ordinario:Celebracao
	var celebracao_tempo_comum:Celebracao
	var celebracao_tempo:Celebracao
	var celebracao_festa:Celebracao
	var mes:int = 0
	var dia:int = 0
	var parte:Parte
	var cantico:Parte
	celebracao = Celebracao.new()
	if festa:
		pass
	if hora == Globais.Hora.COMPLETAS or hora == Globais.Hora.I_COMPLETAS:
		celebracao_ordinario = colecao.buscar_ordinario(Globais.Hora.COMPLETAS, Globais.Tempo.NAO_SE_APLICA)
		#celebracao_tempo_comum = salterios[Globais.Tempo.COMUM]["Completas"].buscar(hora, dia_da_semana, 0, 0, '')
		celebracao_tempo_comum = colecao.buscar_celebracao(hora, Globais.Tempo.COMUM, 0, dia_da_semana)
		if tempo == Globais.Tempo.QUARESMA \
		or tempo == Globais.Tempo.CINZAS \
		or tempo == Globais.Tempo.SEMANA_SANTA:
			celebracao_tempo = colecao.buscar_celebracao(Globais.Hora.COMPLETAS, tempo, semana, Globais.DiaDaSemana.DOMINGO)
		elif tempo  == Globais.Tempo.PASCOA \
		or tempo == Globais.Tempo.OITAVA_PASCOA:
			pass
		else:
			celebracao_tempo = celebracao_tempo_comum
		
		# Montagem
		celebracao.partes = []
		# Versículo introdutório:
#		if celebracao_tempo.busca_parte(Globais.LugarParte.VERSICULO_INTRODUTORIO):
#			celebracao.partes.append(celebracao_tempo.busca_parte(Globais.LugarParte.VERSICULO_INTRODUTORIO)[0])
#		else:
#			celebracao.partes.append(celebracao_ordinario.busca_parte(Globais.LugarParte.VERSICULO_INTRODUTORIO)[0])
		celebracao.partes.append(_escolher_prioritarios(
			hora,
			Globais.LugarParte.VERSICULO_INTRODUTORIO,
			tempo,
			celebracao_ordinario,
			celebracao_tempo_comum,
			celebracao_tempo,
			celebracao_festa
		)[0])
		
		# Hino:
#		if celebracao_tempo.busca_parte(Globais.LugarParte.HINO):
#			celebracao.partes.append(celebracao_tempo.busca_parte(Globais.LugarParte.HINO)[0])
#		else:
#			celebracao.partes.append(celebracao_ordinario.busca_parte(Globais.LugarParte.HINO)[0])
		celebracao.partes.append(_escolher_prioritarios(
			hora,
			Globais.LugarParte.HINO,
			tempo,
			celebracao_ordinario,
			celebracao_tempo_comum,
			celebracao_tempo,
			celebracao_festa
		)[0])
		
		# Salmos
#		for salmo in celebracao_tempo_comum.busca_parte(Globais.LugarParte.SALMO):
#			celebracao.partes.append(salmo)
#			celebracao.partes[0] = celebracao_ordinario.partes[0]
#			for p in range(len(celebracao_tempo_comum.partes)): #-1)): # Exceto a antífona do Nunc Dimitis
#				celebracao.partes.append(celebracao_tempo_comum.partes[p])
		for salmo in _escolher_prioritarios(
			hora,
			Globais.LugarParte.SALMO,
			tempo,
			celebracao_ordinario,
			celebracao_tempo_comum,
			celebracao_tempo,
			celebracao_festa
		):
			celebracao.partes.append(salmo)
		
		# Responsório
#		if celebracao_tempo.busca_parte(Globais.LugarParte.RESPONSORIO_SALMO):
#			celebracao.partes.append(celebracao_tempo.busca_parte(Globais.LugarParte.RESPONSORIO_SALMO)[0])
#		else:
#			celebracao.partes.append(celebracao_ordinario.busca_parte(Globais.LugarParte.RESPONSORIO_SALMO)[0])
		celebracao.partes.append(_escolher_prioritarios(
			hora,
			Globais.LugarParte.RESPONSORIO_LEIT1,
			tempo,
			celebracao_ordinario,
			celebracao_tempo_comum,
			celebracao_tempo,
			celebracao_festa
		)[0])
		
		# Cântico Evangélco
#		cantico = Parte.new()
#		cantico.cantos = celebracao_ordinario.busca_parte(Globais.LugarParte.CANTICO_EVANGELICO)[0].cantos
#		cantico.antifonas = celebracao_ordinario.busca_parte(Globais.LugarParte.CANTICO_EVANGELICO)[0].antifonas
##		if celebracao_tempo.busca_parte(Globais.LugarParte.CANTICO_EVANGELICO):
##			cantico.antifonas = celebracao_tempo.busca_parte(Globais.LugarParte.CANTICO_EVANGELICO)[0].antifonas
#		celebracao.partes.append(cantico)
		celebracao.partes.append(_escolher_prioritarios(
			hora,
			Globais.LugarParte.CANTICO_EVANGELICO,
			tempo,
			celebracao_ordinario,
			celebracao_tempo_comum,
			celebracao_tempo,
			celebracao_festa
		)[0])
		
		# Despedida
#		if celebracao_tempo.busca_parte(Globais.LugarParte.DESPEDIDA):
#			celebracao.partes.append(celebracao_tempo.busca_parte(Globais.LugarParte.DESPEDIDA)[0])
#		else:
#			celebracao.partes.append(celebracao_ordinario.busca_parte(Globais.LugarParte.DESPEDIDA)[0])
		celebracao.partes.append(_escolher_prioritarios(
			hora,
			Globais.LugarParte.DESPEDIDA,
			tempo,
			celebracao_ordinario,
			celebracao_tempo_comum,
			celebracao_tempo,
			celebracao_festa
		)[0])
		
		# Antífona de Nossa Senhora
		celebracao.partes.append(_escolher_prioritarios(
			hora,
			Globais.LugarParte.ANTIFONAS_NOSSA_SENHORA,
			tempo,
			celebracao_ordinario,
			celebracao_tempo_comum,
			celebracao_tempo,
			celebracao_festa
		)[0])
	else:
		pass
#	var parte:Parte = celebracao.parte(0)
#	var estrofes = parte.cantos.montar(parte.antifonas)
	return celebracao

func _escolher_prioritarios(hora:int, lugar:int, tempo_atual:int, ordinario:Celebracao, tempo_comum:Celebracao, tempo:Celebracao, festa:Celebracao) -> Array:
	var partes = []
	var cantos = []
	var antifonas = []
	var partes_festa = []
	if festa:
		partes_festa = festa.busca_parte(lugar)
	var partes_tempo = tempo.busca_parte(lugar)
	var partes_tempo_comum = tempo_comum.busca_parte(lugar)
	var partes_ordinario = ordinario.busca_parte(lugar)
	if festa:
		if partes_festa:
			for p in partes_festa:
				if p.cantos:
					cantos.append(p.cantos)
				if p.antifonas:
					antifonas.append(p.antifonas)
	if partes_tempo:
		if !cantos:
			for p in partes_tempo:
				if p.cantos:
					cantos.append(p.cantos)
		if !antifonas:
			for p in partes_tempo:
				if p.antifonas:
					antifonas.append(p.antifonas)
	if partes_tempo_comum:
		if !cantos:
			for p in partes_tempo_comum:
				if p.cantos:
					cantos.append(p.cantos)
		if !antifonas:
			for p in partes_tempo_comum:
				if p.antifonas:
					antifonas.append(p.antifonas)
	if partes_ordinario:
		if !cantos:
			for p in partes_ordinario:
				if p.cantos:
					cantos.append(p.cantos)
		if !antifonas:
			for p in partes_ordinario:
				if p.antifonas:
					antifonas.append(p.antifonas)
	for n in range(len(cantos)):
		partes.append(Parte.new())
		partes[-1].cantos = cantos[n]
		if antifonas:
			partes[-1].antifonas = antifonas[n]
	return partes

func proxima_parte() -> Parte:
	atual += 1
	if atual >= len(celebracao.partes):
		atual = 0
		emit_signal("fim_celebracao")
	return celebracao.partes[atual]

func parte_anterior() -> Parte:
	atual -= 1
	if atual < 0:
		atual = len(celebracao.partes) - 1
	return celebracao.partes[atual]

func parte_atual():
	return celebracao.partes[atual]

#func nova_celebracao(ntipo, nhora, npartes:Array):
#	var instancia:Celebracao = Celebracao.new()
#	instancia.tipo = ntipo
#	instancia.hora = nhora
#	instancia.partes = npartes
#	return instancia
#func tempo_atual() -> int:
#	var hoje = OS.get_date()
#	if hoje['month'] >= 11:
#		var dias_para_natal:int
#		if hoje['month'] == 11:
#			dias_para_natal = 30 - hoje['day'] + 25
#			if (hoje['day'] == 27 and hoje['weekday'] == 0) \
#			or (hoje['day'] == 28 and hoje['weekday'] <= 1) \
#			or (hoje['day'] == 29 and hoje['weekday'] <= 2) \
#			or (hoje['day'] == 30 and hoje['weekday'] <= 3) :
#				return Celebracao.Tempo.ADVENTO
#			else:
#				return Celebracao.Tempo.COMUM
#		else:
#			dias_para_natal = 25 - hoje['day']
#		if dias_para_natal <= 8:
#			return Celebracao.Tempo.DE_17_DEZ_A_1_JAN
#		if (hoje['day'] == 1 and hoje['weekday'] <= 4) \
#		or (hoje['day'] == 2 and hoje['weekday'] <= 5):
#			return Celebracao.Tempo.ADVENTO
#	if hoje['month'] == 1:
#		if hoje['day'] == 1:
#			return Celebracao.Tempo.DE_17_DEZ_A_1_JAN
#		if hoje['day'] < 9:
#			return Celebracao.Tempo.NATAL
#		if (hoje['day'] == 9 and hoje['weekday'] <= 1) \
#		or (hoje['day'] == 10 and (hoje['weekday'] < 2 or hoje['weekday'] > 3)) \
#		or (hoje['day'] == 11 and (hoje['weekday'] < 1 or hoje['weekday'] > 3)) \
#		or (hoje['day'] == 12 and (hoje['weekday'] == 0 or hoje['weekday'] == 6)) \
#		or (hoje['day'] == 13 and hoje['weekday'] == 0): # Até o Batismo do Senhor 
#			return Celebracao.Tempo.NATAL
#		return Celebracao.Tempo.COMUM
#	if hoje['month'] == 2:
#		pass
#	if hoje['month'] == 3:
#		if pascoa[1] == 3 and hoje['day'] < pascoa[0] - 7:
#			return Celebracao.Tempo.SEMANA_SANTA_E_OITAVA_PASCOA
#		elif 
#	return Celebracao.Tempo.COMUM

# Called when the node enters the scene tree for the first time.
func _ready():
	colecao = load("res://assets/Salterio/Colecoes/tudo.tres")
#	salterios['ordinarios'] = {
#		'Completas': load('res://assets/Salterio/Ordinário/Completas/ordinario completas.tres'),
#	}
#	salterios[Globais.Tempo.COMUM] = {
#		'Completas': load('res://assets/Salterio/Celebracoes/Completas/COMUM-Completas.tres')
#	}
#	salterios[Globais.Tempo.QUARESMA] = {
#		 'ordinario Completas': load("res://assets/Salterio/Quaresma/Completas - quaresma.tres")
#	}
#	salterios[Globais.Tempo.CINZAS] = {
#		'ordinario Completas': load("res://assets/Salterio/Quaresma/Completas - quaresma.tres")
#	}
#	salterios[Globais.Tempo.SEMANA_SANTA] = {
#		'ordinario Completas': load("res://assets/Salterio/Quaresma/Completas - quaresma.tres")
#	}
#	salterios['proprios'] = {
#
#	}


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
