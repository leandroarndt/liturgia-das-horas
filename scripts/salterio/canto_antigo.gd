extends Resource

class_name Canto_antigo

export(String) var nome
export(Array,String) var estrofes
export(Array,String) var refroes
#export(String) var caminho

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func montar(antifona:Estrofe=Estrofe.new(), refrao:int=-1):
	var tudo = []
	if antifona.versos:
		tudo.append(antifona)
	for e in estrofes:
		#var est = load(caminho+'estrofe-'+String(e)+'.tres')
		tudo.append(load(resource_path.get_base_dir()+'/'+'estrofe-'+e+'.tres'))
		if refrao >= 0 and Globais.cantar_refroes:
			tudo.append(load(resource_path.get_base_dir()+'/'+'refrao-'+refroes[refrao]+'.tres'))
		elif Globais.repetir_antifona:
			if antifona.versos:
				tudo.append(antifona)
	var checagem = Directory.new()
	if checagem.file_exists(resource_path.get_base_dir()+'/'+'gloria.tres'):
		tudo.append(load(resource_path.get_base_dir()+'/'+'gloria.tres'))
	if antifona.versos:
		tudo.append(antifona)
	return tudo
	
func lista_refroes():
	var lista = []
	for r in refroes:
		var refrao:Estrofe = load(resource_path.get_base_dir()+'/'+'refrao-'+String(r)+'.tres')
		lista.append([r, refrao.nome])
	return lista

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
