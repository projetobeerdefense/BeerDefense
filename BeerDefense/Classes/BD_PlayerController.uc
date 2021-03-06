class BD_PlayerController extends BD_IsoCameraController;

var array<BD_Caminho> aCaminhos;             //Array de caminhos usados pela Carracao
var int indexRotas;
var int proxIndexRota;

var BD_CarrocaController carFollowBot;   //Controller - Carroca
var BD_CarrocaPawn carFollowPawn;        //Pawn - Carroca

var array<BD_AnaoGuerreiroController> playerFollowCarController;   //Controller - Anao
var array<BD_AnaoGuerreiroPawn> playerFollowCarPawn;        //Pawn - Anao

var vector vSpotLocation;                  //Variavel usada para determinar a posicao dos Spots
var array<BD_BotMarker> aSpots;               //Array de Spots usados pelos Anao

var bool bBotSpawned;                      //Variavel de controle para saber se o Bot Já nasceu

var bool bFirstplay;

var BD_SpawnPlayer spawns;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	self.startRota();
}

function startRota()
{
    local array<BD_Path> arrayAux;
	local BD_Path pathAux;
	local BD_MapInfo BDmapInfo;
	local int i;

	BDmapInfo = BD_MapInfo(WorldInfo.GetMapInfo());
    
    aCaminhos.Add(BDmapInfo.getNumRotas());

    for(i=0;i<BDmapInfo.getNumRotas();i++)
    {
       arrayAux.Length = 0;
    	
       foreach WorldInfo.AllNavigationPoints(class'BD_Path', pathAux)
       {
          if(pathAux.Nome == Name("Caminho"@i))
		  {
			    arrayAux.AddItem(pathAux);
		  }
	   }
	   
	   aCaminhos[i] = new (none) class'BD_Caminho';
	   aCaminhos[i].setCaminho(arrayAux);
	   aCaminhos[i].setIndex(0);
    }
}

function SpawnBot(Vector vSpawnLocation)
{
	//Spawn e Configurção da Carroça da Carroca
	carFollowBot = Spawn(class'BD_CarrocaController',,,vSpawnLocation);
	carFollowPawn = Spawn(class'BD_CarrocaPawn',,,vSpawnLocation);
	carFollowBot.Possess(carFollowPawn,false);
	carFollowBot.CurrentGoal = self.aCaminhos[indexRotas].getAtualPath();
	carFollowPawn.InitialLocation = vSpawnLocation;
	carFollowPawn.SetPhysics(PHYS_Falling);

	BD_IsoCameraPawn(Pawn).setFollowActor(carFollowPawn);

	vSpawnLocation = SetaSpotsPlayer(vSpawnLocation);

	//Spawn e Configurção do Anão	
	vSpawnLocation.z = 80;
	//Move o anão para tras(negativo) e para frente(positivo) da carroça
	vSpawnLocation.x = carFollowBot.Location.X;
	//Move o anão para esquerda(negativo) e para direita(positivo) da carroça (olhando por tras da carroça)
	vSpawnLocation.y = carFollowBot.Location.Y - 150;

    //Spawn e config. dos Spots
    vSpotLocation = carFollowBot.Location;
    vSpotlocation.X += 100;
    aSpots[0] = Spawn(class'BD_BotMarker',,,vSpotLocation);
	 
    vSpotLocation = carFollowBot.Location;
    vSpotLocation.X += 150;
    aSpots[1] = Spawn(class'BD_BotMarker',,,vSpotLocation);

    vSpotLocation = carFollowBot.Location;
    vSpotLocation.X += 200;
    aSpots[2] = Spawn(class'BD_BotMarker',,,vSpotLocation);

    vSpotLocation = carFollowBot.Location;
    vSpotLocation.X -= 250;
    aSpots[3] = Spawn(class'BD_BotMarker',,,vSpotLocation);
	
	spawns.SpawnBot(vSpawnLocation, aSpots, 0,0,0,0);

	//playerFollowCarController[0] = Spawn(class'BD_AnaoGuerreiroController',,,vSpawnLocation);
	//playerFollowCarPawn[0] = Spawn(class'BD_AnaoGuerreiroPawn',,,vSpawnLocation);
	//playerFollowCarController[0].Possess(playerFollowCarPawn[0],false);
	//playerFollowCarController[0].CurrentGoal = self.aSpots[0];
	//playerFollowCarPawn[0].SetPhysics(PHYS_Falling);

	//vSpawnLocation.x = carFollowBot.Location.X;
	//vSpawnLocation.y = carFollowBot.Location.Y + 150;

	//playerFollowCarController[1] = Spawn(class'BD_AnaoGuerreiroController',,,vSpawnLocation);
	//playerFollowCarPawn[1] = Spawn(class'BD_AnaoGuerreiroPawn',,,vSpawnLocation);
	//playerFollowCarController[1].Possess(playerFollowCarPawn[1],false);
	//playerFollowCarController[1].CurrentGoal = self.aSpots[1];
	//playerFollowCarPawn[1].SetPhysics(PHYS_Falling);

	//vSpawnLocation.x += 50;

	//playerFollowCarController[2] = Spawn(class'BD_AnaoGuerreiroController',,,vSpawnLocation);
	//playerFollowCarPawn[2] = Spawn(class'BD_AnaoGuerreiroPawn',,,vSpawnLocation);
	//playerFollowCarController[2].Possess(playerFollowCarPawn[2],false);
	//playerFollowCarController[2].CurrentGoal = self.aSpots[2];
	//playerFollowCarPawn[2].SetPhysics(PHYS_Falling);

	//vSpawnLocation.x += 50;

	//playerFollowCarController[3] = Spawn(class'BD_AnaoGuerreiroController',,,vSpawnLocation);
	//playerFollowCarPawn[3] = Spawn(class'BD_AnaoGuerreiroPawn',,,vSpawnLocation);
	//playerFollowCarController[3].Possess(playerFollowCarPawn[3],false);
	//playerFollowCarController[3].CurrentGoal = self.aSpots[3];
	//playerFollowCarPawn[3].SetPhysics(PHYS_Falling);

    //Seta true para dizer que bot foram 'spawned'
    bBotSpawned = true;
}

function vector SetaSpotsPlayer(vector vSpawnLocation)
{
	//Spawn e config. dos Spots
	vSpotLocation = carFollowBot.Location;
	vSpotlocation.X += 30;
	aSpots[0] = Spawn(class'BD_BotMarker',,,vSpotLocation);
	 
	vSpotLocation = carFollowBot.Location;
	vSpotLocation.X -= 30;
	aSpots[1] = Spawn(class'BD_BotMarker',,,vSpotLocation);
	 
	vSpotLocation = carFollowBot.Location;
	vSpotLocation.Y += 30;
	aSpots[2] = Spawn(class'BD_BotMarker',,,vSpotLocation);
	 
	vSpotLocation = carFollowBot.Location;
	vSpotLocation.Y -= 30;
	aSpots[3] = Spawn(class'BD_BotMarker',,,vSpotLocation);
	
	return vSpawnLocation;
}

//function AtualizaSpots(vector vNewLocation)
//{
//	//Spawn e config. dos Spots
//	vSpotLocation = carFollowBot.Location;
//	vSpotlocation.X += 30;
//	aSpots[0] = Spawn(class'BD_BotMarker',,,vSpotLocation);
	 
//	vSpotLocation = carFollowBot.Location;
//	vSpotLocation.X -= 30;
//	aSpots[1] = Spawn(class'BD_BotMarker',,,vSpotLocation);
	 
//	vSpotLocation = carFollowBot.Location;
//	vSpotLocation.Y += 30;
//	aSpots[2] = Spawn(class'BD_BotMarker',,,vSpotLocation);
	 
//	vSpotLocation = carFollowBot.Location;
//	vSpotLocation.Y -= 30;
//	aSpots[3] = Spawn(class'BD_BotMarker',,,vSpotLocation);
	
//	return vSpawnLocation;
//}

function AtualizaSpots(vector vNewLocation)
{
    local vector vAtualizaLocation;

    vAtualizaLocation = vNewLocation;
	vAtualizaLocation.x += 100;
	vAtualizaLocation.y += 100;
    aSpots[0].SetLocation(vAtualizaLocation);

    vAtualizaLocation = vNewLocation;
	vAtualizaLocation.x -= 100;
	vAtualizaLocation.y -= 100;
    aSpots[1].SetLocation(vAtualizaLocation);

    vAtualizaLocation = vNewLocation;
	vAtualizaLocation.x += 100;
    vAtualizaLocation.y -= 100;
    aSpots[2].SetLocation(vAtualizaLocation);
}
//function PlayerTick(float DeltaTime)
//{
//    vAtualizaLocation = vNewLocation;
//	vAtualizaLocation.x -= 100;
//    vAtualizaLocation.y += 100;
//    aSpots[3].SetLocation(vAtualizaLocation);
//}

function PlayerTick(float DeltaTime)
{
	local float dist;
	
	super.PlayerTick(DeltaTime);

	if(bBotSpawned)
	{
		if(carFollowBot != none)
		{
			dist = VSize(carFollowPawn.Location - carFollowBot.CurrentGoal.Location);

			if(dist < 100)
			{
				if(self.aCaminhos[indexRotas].getAtualPath() == carFollowBot.CurrentGoal && self.aCaminhos[indexRotas].ultimoPath())
				{
					if(proxIndexRota == -1)
					{
						indexRotas = self.aCaminhos[indexRotas].getAtualPath().proximo;
					}
					else
					{
						indexRotas = proxIndexRota;
						proxIndexRota = -1;
					}
					carFollowBot.CurrentGoal = self.aCaminhos[indexRotas].getAtualPath();
				}
				else
				{
					self.aCaminhos[indexRotas].proximoPath();
					carFollowBot.CurrentGoal = self.aCaminhos[indexRotas].getAtualPath();
				}
			}		
		}

		AtualizaSpots(carFollowPawn.Location);
	}
	
	if (!bBotSpawned)
    {
        SpawnBot(Pawn.Location);
        bBotSpawned = true;
        BD_BasePawn(Pawn).InitialLocation = Pawn.Location;
    }
}

DefaultProperties
{
	bBotSpawned=false
	proxIndexRota=-1

}
