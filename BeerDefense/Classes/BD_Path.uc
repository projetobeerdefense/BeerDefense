//--------------------------------------------------------
// Criado por Igor Felga
// Criado em 09/11/2013
// Classe "BD_Path" - Para o Jogo Beer Defense
//--------------------------------------------------------

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

var(Path) private int  iNumCaminho               <DisplayName=Numero do Caminho>;                                      //Numero do caminho a qual o path pertence
var(Path) private int  iPosicao                  <DisplayName=Posicao no Caminho>;                                     //Posição a qual o path pertence no caminho
var(Path) private bool bFimdocaminho             <DisplayName=Fim do Caminho?>;                                        //Se esse path representa o ultimo de um caminho
var(Path) private int  iProximo                  <DisplayName=Proximo Caminho? | EditCondition=bFimdocaminho>;         //Proximo caminho a chamar (Só possivel editar se for fim de caminho)

public function bool fimdocaminho()
{
	return bFimdocaminho;
}

public function int proximo()
{
	return iProximo;
}

public function int numCaminho()
{
	return iNumCaminho;
}

public function int posicao()
{
	return iPosicao;
}

DefaultProperties
{	
	Begin Object NAME=Sprite
		Sprite=Texture2D'EditorResources.Flag1'
	End Object

	Begin Object Class=StaticMeshComponent Name=Flag
        StaticMesh=StaticMesh'Castle_Assets.Meshes.SM_HangingFlag_01'
    End Object

	Begin Object Class=StaticMeshComponent Name=StaticMeshComponent0
		StaticMesh=StaticMesh'Castle_Assets.Meshes.SM_HangingFlag_01'
		CollideActors=false
		Scale3D=(X=0.5,Y=0.5,Z=0.5)

		CastShadow=FALSE
		bCastDynamicShadow=FALSE
		bAcceptsLights=FALSE
		bForceDirectLightMap=FALSE
	End Object
 	Components.Add(StaticMeshComponent0)

	bHidden=true
}
