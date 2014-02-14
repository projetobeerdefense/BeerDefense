//-----------------------------------------------------------
// Criado por Fernando Ribeiro
// Criado em 20/11/2013
//-----------------------------------------------------------

//-----------------------------------------------------------
// @@ Classe responsavel pelo Pawn do Anão Guerreiro
//-----------------------------------------------------------

class BD_AnaoGuerreiroPawn extends BD_MeleePawn;

DefaultProperties
{
	//defesa basica
	iDefesa = 20
	//atributos basicos
	iForca = 10
	iAgilidade = 10
	iConstituicao = 10
	iSabedoria =10
	//vida inicial
	iMaxhealth = 200+(cons*0.7+agi*0.3+str*0.1)

	Begin Object Class=SkeletalMeshComponent Name=Carroca
        SkeletalMesh=SkeletalMesh'BD_Personagens.anao.anao'
		AnimSets(0)=AnimSet'BD_Personagens.anao.anao_Anims'
        AnimTreeTemplate=AnimTree'BD_Personagens.anao.Anao_AnimTree'
    End Object

    Mesh = Carroca; // Set The mesh for this object
    Components.Add(Carroca); // Attach this mesh to this Actor
}
