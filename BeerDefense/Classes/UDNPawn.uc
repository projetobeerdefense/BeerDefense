class UDNPawn extends UTPawn;

var float CamOffsetDistance_pitch;       //distance to offset the camera from the player
var float CamOffsetDistance_yaw;         //distance to offset the camera from the player
var int IsoCamAngle_pitch;               //pitch angle of the camera
var int IsoCamAngle_yaw;                 //yaw angle of the camera
var float IsoZDistance;                  //pitch angle of the camera

var vector InitialLocation;

//override to make player mesh visible by default
/*
simulated event BecomeViewTarget( PlayerController PC )
{
   local UDNPlayerController UTPC;

   Super.BecomeViewTarget(PC);

   if (LocalPlayer(PC.Player) != None)
   {
      UTPC = UDNPlayerController(PC);
      if (UTPC != None)
      {
         //set player controller to behind view and make mesh visible
         UTPC.SetBehindView(true);
         SetMeshVisibility(UTPC.bBehindView);
         UTPC.bNoCrosshair = true;
      }
   }
}
*/
simulated function bool CalcCamera( float fDeltaTime, out vector out_CamLoc, out rotator out_CamRot, out float out_FOV )
{
   local BD_CarrocaPawn aux;
   local int i;

   i=0;

   foreach WorldInfo.Game.AllActors(class'BD_CarrocaPawn', aux)
   {
           i++;
           `log("Vezes do Foreach:"@i);
           out_CamLoc = aux.Location;
   }

   out_CamLoc.X -= Cos(IsoCamAngle_pitch * UnrRotToRad) * CamOffsetDistance_pitch;
   out_CamLoc.Y -= Cos(IsoCamAngle_yaw * UnrRotToRad) * CamOffsetDistance_yaw;
   out_CamLoc.Z += IsoZDistance;
   //out_CamLoc.Z += Sin(IsoCamAngle_pitch * UnrRotToRad) * CamOffsetDistance_pitch;


   out_CamRot.Pitch = -1 * IsoCamAngle_pitch;
   out_CamRot.Yaw = IsoCamAngle_yaw;
   out_CamRot.Roll = 0;

   return true;
}

simulated singular event Rotator GetBaseAimRotation()
{
   local rotator   POVRot, tempRot;

   tempRot = Rotation;
   tempRot.Pitch = 0;
   SetRotation(tempRot);
   POVRot = Rotation;
   POVRot.Pitch = 0;

   return POVRot;
}

defaultproperties
{
	IsoCamAngle_pitch=7282 //35.264 degrees
	IsoCamAngle_yaw=8192
	CamOffsetDistance_pitch=500.0
	CamOffsetDistance_yaw=850.0
	IsoZDistance=500
}

// Lembrar www.gamedev.net/