class BD_Caminho extends Object;

var private int iIndex;                     //Valor index de qual é o atual path
var private array<BD_Path> Caminho;         //Array contendo todos os path desse caminho

public function setIndex(int value)
{
	iIndex = value;
}

public function int getIndex()
{
    return iIndex;
}

public function BD_Path getAtualPath()
{
	return Caminho[iIndex];
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
	if(Caminho[iIndex].fimdocaminho)
		return true;
	else
		return false;
}

public function BD_path proximoPath()
{
     iIndex++;
	 return Caminho[iIndex];
}

public function toggleShowPath()
{
	local int i;
	
	for(i=0;i<Caminho.Length;i++)
	{
		Caminho[i].SetHidden(!Caminho[i].bHidden);
	}
}

DefaultProperties
{
}
