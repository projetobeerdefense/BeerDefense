class BD_IsoCameraPawn extends UTPawn;

var BD_IsoCameraProperties CameraProperties;
var actor Follow;

/**********************************
           * Eventos * 
***********************************/

//Sobrescreve evento para exibir player como padr�o
simulated event BecomeViewTarget( PlayerController PC )
{
   local UTPlayerController UTPC;

   Super.BecomeViewTarget(PC);

   if (LocalPlayer(PC.Player) != none)
   {
      UTPC = UTPlayerController(PC);
      if (UTPC != none)
      {
			//Seta o player controller para tr�s da mesh e a torna visivel
			UTPC.SetBehindView(true);
			SetMeshVisibility(true); 
			UTPC.bNoCrosshair = true;
      }
   }
}

//S� atualiza a rota��o do Pawn enquanto estiver se movendo
simulated function FaceRotation(rotator NewRotation, float DeltaTime)
{
	// N�o atualiza se estiver parado
	if (Normal(Acceleration)!=vect(0,0,0))
	{
		if ( Physics == PHYS_Ladder )
		{
			NewRotation = OnLadder.Walldir;
		}
		else if ( (Physics == PHYS_Walking) || (Physics == PHYS_Falling) )
		{
			NewRotation = rotator((Location + Normal(Acceleration)) - Location);
			NewRotation.Pitch = 0;
		}
		
		SetRotation(NewRotation);
	}
	
}

//Segue a rota��o do player controller
simulated function bool CalcCamera( float fDeltaTime, out vector out_CamLoc, out rotator out_CamRot, out float out_FOV )
{
	local vector vHitLoc, vHitNorm, vEnd, vStart, vCamAltura, vFollow;

	//Verifica se tem algum actor para seguir, sen�o ativa a Freecam
	if(Follow == none)
		vFollow = Location;
	else
		vFollow = Follow.Location;

	vCamAltura = vect(0,0,0);

	//Calcula a Altura do Offset (baseado no Offset)
	vCamAltura.Z = -(CameraProperties.fCamOffsetDistance / tan(90));
	vStart = vFollow;
	
	//Camera segue o player controller por tras
	vEnd = (vFollow + vCamAltura) - (Vector(Controller.Rotation) * CameraProperties.fCamOffsetDistance);
	out_CamLoc = vEnd;

	//Verifica se a rota da camera esta em uma parede ou no ch�o
	if(Trace(vHitLoc, vHitNorm, vEnd, vStart, false, vect(12,12,12)) != none)
	{
		out_CamLoc = vHitLoc + vCamAltura;
	}
	
	//Fun��o para apontar a posi��o da camera
	out_CamRot=rotator((vFollow + vCamAltura) - out_CamLoc);

	//Inclina��o da camera
	out_CamRot.pitch = -CameraProperties.fPitchAng * DegToUnrRot;

	return true;
}

/**********************************
	    * Fun��es * 
***********************************/

exec function CamZoomIn()
{
	`Log("Zoom in");
	if(CameraProperties.fCamOffsetDistance > CameraProperties.fCamMinDistance)
	{
		CameraProperties.fCamOffsetDistance -= CameraProperties.fCamZoomTick;
	}
}

exec function CamZoomOut()
{
	`Log("Zoom out");
	if(CameraProperties.fCamOffsetDistance < CameraProperties.fCamMaxDistance)
	{
		CameraProperties.fCamOffsetDistance += CameraProperties.fCamZoomTick;
	}
}

//Seta qual actor a camera tem que seguir
simulated function setFollowActor(actor setFollow)
{
    Follow = setFollow;
}

DefaultProperties
{	
	bCollideActors=false
	CameraProperties=BD_IsoCameraProperties'BD_Principal.Archetype.BD_IsoCamProp'
}