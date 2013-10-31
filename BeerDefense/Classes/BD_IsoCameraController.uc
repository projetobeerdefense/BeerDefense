class BD_IsoCameraController extends UTPlayerController;

/**********************************
	   * Funções * 
***********************************/

//Controller gira conforme input
function UpdateRotation( float DeltaTime )
{
	local Rotator rDeltaRot, rNewRotation, rViewRotation;

	rViewRotation = Rotation;
	if (Pawn != none)
	{
		Pawn.SetDesiredRotation(rViewRotation);
	}

	// Calcula o Delta para aplicar no ViewRotation
	rDeltaRot.Yaw = PlayerInput.aTurn;
	// Trava a rotação somente para o horizontal
	rDeltaRot.Pitch = 0;

	ProcessViewRotation( DeltaTime, rViewRotation, rDeltaRot );
	SetRotation(rViewRotation);

	rNewRotation = rViewRotation;
	rNewRotation.Roll = Rotation.Roll;

	if ( Pawn != none )
	{ 
		// Avisa o Pawn da rotação
		Pawn.FaceRotation(rNewRotation, deltatime);
	}
}   

/**********************************
	   * States * 
***********************************/

//@@@@@ -------- Estado Responsavel em dizer se o player está andando -------- @@@@@
//Atualiza a rotação do player quando estiver andando
state PlayerWalking
{
	ignores SeePlayer, HearNoise, Bump;

	function ProcessMove(float DeltaTime, vector NewAccel, eDoubleClickDir DoubleClickMove, rotator DeltaRot)
	{
		local Vector vTempAccel;
		local Rotator rCameraRotationYawOnly;
		
		if( Pawn == None )
		{
			 return;
		}

		vTempAccel.Y = PlayerInput.aStrafe * DeltaTime * 100 * PlayerInput.MoveForwardSpeed;
		vTempAccel.X = PlayerInput.aForward * DeltaTime * 100 * PlayerInput.MoveForwardSpeed;
		//Nenhum movimento vertical por enquanto
		vTempAccel.Z = 0; 
      
		//Pega o controller yaw para transformar nossa aceleração/movimento
		rCameraRotationYawOnly.Yaw = Rotation.Yaw;  
		//Transforma o input pela orientação da camera padrão
		vTempAccel = vTempAccel >> rCameraRotationYawOnly;
		Pawn.Acceleration = vTempAccel;
   
		// Avisa o Pawn da rotação
		Pawn.FaceRotation(Rotation,DeltaTime);

		CheckJumpOrDuck();
	}
}

DefaultProperties
{
}