//-----------------------------------------------------------
// Classe "BD_CarrocaPawn" - Para o Jogo Beer Defense
//
// Codigo Baseado no do Livro - "Beginning iOS 3D Unreal Games Development"
// Criado por Robert Chin
//
// Modificaçõoes feita para o Jogo "Beer Defense"
// Modificado por Igor Felga
// Criado em 11/08/2012 - 16:35
// Revisado por Fernando Ribeiro
// Data: 08/08/2013
//-----------------------------------------------------------

//-----------------------------------------------------------
// @@ Classe responsavel pelo Pawn da Carroça
//-----------------------------------------------------------

class BD_CarrocaPawn extends BD_Pawn;

DefaultProperties
{	
	Begin Object Class=SkeletalMeshComponent Name=Carroca
        SkeletalMesh=SkeletalMesh'BD_Personagens.anao.anao'
		AnimSets(0)=AnimSet'BD_Personagens.anao.anao_Anims'
        AnimTreeTemplate=AnimTree'BD_Personagens.anao.Anao_AnimTree'
    End Object

    Mesh = Carroca; // Set The mesh for this object
    Components.Add(Carroca); // Attach this mesh to this Actor
}