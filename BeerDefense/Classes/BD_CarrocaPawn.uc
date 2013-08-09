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

class BD_CarrocaPawn extends UDNPawn;

var int iDef;
var int iIndex;
var int iMaxBarril;
var int iBarrilLife[6];

/**********************************
           * Eventos * 
***********************************/

simulated event TakeDamage(int Damage, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{	
	local int iActualDamage;
	local Controller need;

	if(DamageCauser.isa('BD_Inimigo_Lagarto_Thief_Pawn'))
	{
		iBarrilLife[BD_Inimigo_Lagarto_Thief_Pawn(DamageCauser).index] = iBarrilLife[BD_Inimigo_Lagarto_Thief_Pawn(DamageCauser).index] - Damage;
		if(iBarrilLife[BD_Inimigo_Lagarto_Thief_Pawn(DamageCauser).index] <= 0)
		{
			need = BD_Inimigo_Lagarto_Thief_Pawn(DamageCauser).controller;
			BD_Inimigo_Lagarto_Thief_Controller(need).goaway();
		}
	}
	else
	{
		if(DamageCauser.isa('BD_InimigoPawn'))
		{ 
			iActualDamage = Damage - iDef;
			if(iActualDamage < 1) 
			{
				iActualDamage = 1;
			}
			super.TakeDamage(iActualDamage, EventInstigator, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
		}
	}
}

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal)
{	
    local int iCont;  

	super.Touch(Other, OtherComp, HitLocation, HitNormal);
	
    if(Other.isa('BD_Inimigo_Lagarto_Thief_Pawn'))
    { 
		iCont = VerificaSeExisteBarril();
		
		if(iCont >= 6)
		{
			SemBarris();
		}
	}
}


/**********************************
			* Funções * 
***********************************/

function MenosIndex()
{
	iIndex--;
}

function SemBarris()
{
	TriggerGlobalEventClass(class'BD_SecEvent_Over', self, 0);
}

function int VerificaSeExisteBarril()
{
    local int iCont;  

	iCont = 0;	
	iIndex ++; 

	if(iIndex >= iMaxBarril)
	{
		iIndex = 0;
	}
	for(iCont=0; iCont < 6 ; iCont++)
	{
		if(iIndex < 6)
		{
			if(iBarrilLife[iIndex] <= 0)
			{
				iIndex++;
			}
			else
			{
				BD_Inimigo_Lagarto_Thief_Pawn(other).index = iIndex;
				break;
			}
		}
		else
		{
			iIndex = 0;
		}
	}

	return iCont;
}

DefaultProperties
{	
	iDef = 50	
	iIndex = -1
	iMaxBarril = 6
	iBarrilLife[0] = 100
	iBarrilLife[1] = 100
	iBarrilLife[2] = 100
	iBarrilLife[3] = 100
	iBarrilLife[4] = 100
	iBarrilLife[5] = 100

    Begin Object Class=SkeletalMeshComponent Name=Carroca
        SkeletalMesh=SkeletalMesh'carroca.skeletal_mesh.carroca_joint'
        BlockRigidBody=true
        CollideActors=true
    End Object

    Mesh = Carroca; // Set The mesh for this object
    Components.Add(Carroca); // Attach this mesh to this Actor
}