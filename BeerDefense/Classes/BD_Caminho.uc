class BD_Caminho extends Object;

var private int index;
var private array<BD_Path> Caminho;

public function setIndex(int value)
{
	index = value;
}

public function int getIndex()
{
    return index;
}

public function BD_Path getAtualPath()
{
	return Caminho[index];
}

public function setCaminho(array<BD_Path> rota)
{
	Caminho = rota;
}

public function int tamCaminho()
{
	return Caminho.Length;
}

public function bool ultimoPath()
{
	if(Caminho[index].Fimdocaminho)
		return true;
	else
		return false;
}

public function BD_path proximoPath()
{
     index++;
	 return Caminho[index];
}

DefaultProperties
{
}
