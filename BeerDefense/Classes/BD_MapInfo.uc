class BD_MapInfo extends MapInfo
	HideCategories(Object);

var(BeerDefense) private int iNumeroRotas       <DisplayName=Numero de Caminhos>;   //Quantidade de caminhos que o mapa vai possuir

public function int getNumRotas()
{
	return iNumeroRotas;
}

DefaultProperties
{
}
