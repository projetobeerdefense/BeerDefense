class BD_CarrocaPawnCamera extends UTPawn;

var float fCamOffsetDistance; //Distancia da camera para o jogador em unidades do Unreal
var float fCamMinDistance, fCamMaxDistance;
var float fCamZoomTick; //Quantidade para movimentar o zoom in/out
var float fCamHeight; //Quão alto está a camera da pelvis
var float fPitchAng;   //Valor do angulo desejado, em graus

/**********************************
           * Eventos * 
***********************************/

//Sobrescreve evento para exibir player como padrão
simulated event BecomeViewTarget( PlayerController PC )
{
   local UTPlayerController UTPC;

   Super.BecomeViewTarget(PC);

   if (LocalPlayer(PC.Player) != none)
   {
      UTPC = UTPlayerController(PC);
      if (UTPC != none)
      {
			//Seta o player controller para trás da mesh e a torna visivel
			UTPC.SetBehindView(true);
			SetMeshVisibility(true); 
			UTPC.bNoCrosshair = true;
      }
   }
}

//Só atualiza a rotação do Pawn enquanto estiver se movendo
simulated function FaceRotation(rotator NewRotation, float DeltaTime)
{
	// Não atualiza se estiver parado
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

//Segue a rotação do player controller
simulated function bool CalcCamera( float fDeltaTime, out vector out_CamLoc, out rotator out_CamRot, out float out_FOV )
{
	local vector vHitLoc, vHitNorm, vEnd, vStart, vCamAltura;

	vCamAltura = vect(0,0,0);

	vCamAltura.Z = -(fCamOffsetDistance / tan(90));
	vStart = Location;
	
	//Camera segue o player controller por tras
	vEnd = (Location + vCamAltura) - (Vector(Controller.Rotation) * fCamOffsetDistance);
	out_CamLoc = vEnd;

	//Verifica se a rota da camera esta em uma parede ou no chão
	if(Trace(vHitLoc, vHitNorm, vEnd, vStart, false, vect(12,12,12)) != none)
	{
		out_CamLoc = vHitLoc + vCamAltura;
	}
	
	//Função para apontar a posição da camera
	out_CamRot=rotator((Location + vCamAltura) - out_CamLoc);

	//Inclinação da camera
	out_CamRot.pitch = -fPitchAng * DegToUnrRot;

	`log("out_CamLoc.X="@out_CamLoc.X);
	`log("out_CamLoc.Y="@out_CamLoc.Y);
	`log("out_CamLoc.Z="@out_CamLoc.Z);

	return true;
}

/**********************************
	    * Funções * 
***********************************/

exec function CamZoomIn()
{
	`Log("Zoom in");
	if(fCamOffsetDistance > fCamMinDistance)
	{
		fCamOffsetDistance -= fCamZoomTick;
	}
}

exec function CamZoomOut()
{
	`Log("Zoom out");
	if(fCamOffsetDistance < fCamMaxDistance)
	{
		fCamOffsetDistance += fCamZoomTick;
	}
}


DefaultProperties
{	
	fCamMinDistance = 100.0
	fCamMaxDistance = 1000.0
   	fCamOffsetDistance=500.0
	fCamZoomTick=50.0

	fPitchAng=37.5
}