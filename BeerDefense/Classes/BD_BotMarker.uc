class BD_BotMarker extends Actor;

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal)
{
    `log(self@"BotMarker Has Been Touched");
}

DefaultProperties
{
	Begin Object Class=SkeletalMeshComponent Name=Carroca
		SkeletalMesh=SkeletalMesh'BD_Personagens.anao.anao'
		Scale3D=(X=3.0,Y=3.0,Z=3.0)
		BlockRigidBody=false
		CollideActors=false
	End Object

	bhidden = true
	Components.Add(Carroca)
}
