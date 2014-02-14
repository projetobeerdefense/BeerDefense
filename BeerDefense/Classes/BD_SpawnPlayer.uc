class BD_SpawnPlayer extends PlayerController;

var array<BD_AnaoGuerreiroController> playerFollowCarController;
var array<BD_AnaoGuerreiroPawn> playerFollowCarPawn;

function SpawnBot(Vector vSpawnLocation, array<BD_BotMarker> aSpots,int char1, int char2, int char3, int char4) 
{
	
    //Spawn e config. dos Spots
    if(char1 ==0){
	playerFollowCarController[0] = Spawn(class'BD_AnaoGuerreiroController',,,vSpawnLocation);
	playerFollowCarPawn[0] = Spawn(class'BD_AnaoGuerreiroPawn',,,vSpawnLocation);
	playerFollowCarController[0].Possess(playerFollowCarPawn[0],false);
	playerFollowCarController[0].CurrentGoal = aSpots[0];
	playerFollowCarPawn[0].SetPhysics(PHYS_Falling);
    }

	vSpawnLocation.x = vSpawnLocation.X+150 ;
	vSpawnLocation.y = vSpawnLocation.X+150;
	if(char2 == 0){
	playerFollowCarController[1] = Spawn(class'BD_AnaoGuerreiroController',,,vSpawnLocation);
	playerFollowCarPawn[1] = Spawn(class'BD_AnaoGuerreiroPawn',,,vSpawnLocation);
	playerFollowCarController[1].Possess(playerFollowCarPawn[1],false);
	playerFollowCarController[1].CurrentGoal = aSpots[1];
	playerFollowCarPawn[1].SetPhysics(PHYS_Falling);
	}

	vSpawnLocation.x = vSpawnLocation.X+150;
	vSpawnLocation.y = vSpawnLocation.X+150;
	if(char3 == 0){
	playerFollowCarController[2] = Spawn(class'BD_AnaoGuerreiroController',,,vSpawnLocation);
	playerFollowCarPawn[2] = Spawn(class'BD_AnaoGuerreiroPawn',,,vSpawnLocation);
	playerFollowCarController[2].Possess(playerFollowCarPawn[2],false);
	playerFollowCarController[2].CurrentGoal = aSpots[2];
	playerFollowCarPawn[2].SetPhysics(PHYS_Falling);
	}
	vSpawnLocation.x = vSpawnLocation.X+150 ;
	vSpawnLocation.y = vSpawnLocation.X+150;
	vSpawnLocation.x += 50;
	if(char4 == 0){
	playerFollowCarController[3] = Spawn(class'BD_AnaoGuerreiroController',,,vSpawnLocation);
	playerFollowCarPawn[3] = Spawn(class'BD_AnaoGuerreiroPawn',,,vSpawnLocation);
	playerFollowCarController[3].Possess(playerFollowCarPawn[3],false);
	playerFollowCarController[3].CurrentGoal = aSpots[3];
	playerFollowCarPawn[3].SetPhysics(PHYS_Falling);
	}
    //Seta true para dizer que bot foram 'spawned'
    
}

DefaultProperties
{
	bBotSpawned=false
	

}
