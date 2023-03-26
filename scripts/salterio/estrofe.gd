extends Resource

class_name Estrofe


export(Array, String) var versos
export(Array, Resource) var imagens
#export(String) var caminho
#export(int) var tipo
export(Globais.Tipos) var tipo
export(String) var nome

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

class Verso:
	var n:String
	var melodia:String
	var harmonia:String
	var tipo:int

func ler_versos() -> Array:
	var arquivo:File
	var conteudo:String
	var retorno = []
	var verso
	var busca = RegEx.new()
	var encontrado:RegExMatch
	busca.compile('(?<harmonia>(?<=%harmonia\\n)(.|\\n)*(?=\\n%\\/harmonia))(.|\\n)*(?<recitacao>(?<=%recitação\\n)(.|\\n)*(?=\\n%\\/recitação))')
	for v in versos:
		arquivo = File.new()
		if v.begins_with('res://'):
			arquivo.open(v+'.ly', File.READ)
		else:
			arquivo.open(resource_path.get_base_dir()+'/'+v+'.ly', File.READ)
		conteudo = arquivo.get_as_text()
		arquivo.close()
		encontrado = busca.search(conteudo)
		verso = Verso.new()
		verso.n = v
		verso.melodia = encontrado.get_string('recitacao')
		verso.harmonia = encontrado.get_string('harmonia')
		verso.tipo = tipo
		retorno.append(verso)
	return retorno
		
#	return	[
#		'    r1^"A" sols4 sols\\breve mi fas sols \\bar "||" \\break\n    r1^"B" sols4 sols\\breve fas la sols \\bar "||" \\break\n    r1^"C" sols4 sols\\breve fas res mi \\bar "|."'.split('\n', false),
#		"%  r1 r4 mi\\breve dos:m si:7 mi\n%  r1 r4 dos\\breve:m fas:m si:7 mi\n%  r1 r4 mi\\breve fas:m si:7 mi".split('\n', false),
#		[Trecho.RECITADO, Trecho.RECITADO, Trecho.RECITADO],
#	]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
