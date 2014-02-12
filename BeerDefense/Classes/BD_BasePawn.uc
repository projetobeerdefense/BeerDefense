class BD_BasePawn extends UTPawn;

var int iDefesa;
var int iForca;
var int iAgilidade;
var int iConstituicao;
var int iSabedoria;
var int iMaxhealth;

var vector InitialLocation;

event TakeDamage(int iDamage, Controller InstigatedBy, vector vHitLocation, vector vMomentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser) 
{  
	Health = Health - iDamage;  	
    
    if (self.Health <= 0)
    { 
		//self.Death();
	}
}

DefaultProperties
{
}
