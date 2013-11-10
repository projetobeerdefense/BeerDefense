class BD_Path extends NavigationPoint
	Placeable
	HideCategories(VehicleUsage)
	HideCategories(Movement)
	HideCategories(Display)
	HideCategories(Attachment)
	HideCategories(Collision)
	HideCategories(Physics)
	HideCategories(Advanced)
	HideCategories(Debug)
	HideCategories(Mobile)
	HideCategories(Object)
	HideCategories(NavigationPoint);

var(Path) name Nome;           //Tipo de caminho a qual ele pertece
var(Path) bool Fimdocaminho;  //Se é um fim de camainho
var(Path) int  Proximo;       //Proximo caminho a chamar

DefaultProperties
{	
	Begin Object NAME=Sprite
		Sprite=Texture2D'EditorResources.Flag1'
	End Object
	bHidden=false
}
