class BD_Pawn extends UTPawn;

var SoundCue PawnHitSound;
var int iDefesa;
var int iForca;
var int iAgilidade;
var int iConstituicao;
var int iSabedoria;
var int iMaxhealth;

event TakeDamage(int iDamage, Controller InstigatedBy, vector vHitLocation, vector vMomentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser) 
{  
	PlaySound(PawnHitSound);  
	Health = Health - iDamage;  	
    
    if (self.Health <= 0)
    { 
		//self.Death();
	}
}

DefaultProperties
{
}
