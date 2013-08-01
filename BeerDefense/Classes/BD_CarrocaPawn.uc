//-----------------------------------------------------------
// Classe "BD_CarrocaPawn" - Para o Jogo Beer Defense
//
// Codigo Baseado no do Livro - "Beginning iOS 3D Unreal Games Development"
// Criado por Robert Chin
//
// Modificaçõoes feita para o Jogo "Beer Defense"
// Modificado por Igor Felga
// Criado em 11/08/2012 - 16:35
//-----------------------------------------------------------

//-----------------------------------------------------------
// @@ Classe responsavel pelo Pawn da Carroça
//-----------------------------------------------------------

class BD_CarrocaPawn extends UDNPawn;

defaultproperties
{
    Begin Object Class=SkeletalMeshComponent Name=Carroca
        SkeletalMesh=SkeletalMesh'carroca.skeletal_mesh.carroca_joint'
        BlockRigidBody=true
        CollideActors=true
    End Object

    Mesh = Carroca; // Set The mesh for this object
    Components.Add(Carroca); // Attach this mesh to this Actor
}