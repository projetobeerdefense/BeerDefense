class BD_PlayerController extends BD_IsoCameraController;

var array<BD_Caminho> Caminhos;             //Array de caminhos usados pela Carracao
var int indexRotas;
var int proxIndexRota;

var BD_CarrocaController Car_FollowBot;   //Controller - Carroca
var BD_CarrocaPawn Car_FollowPawn;        //Pawn - Carroca

var bool BotSpawned;                      //Variavel de controle para saber se o Bot Já nasceu
var vector SpotLocation;                  //Variavel usada para determinar a posicao dos Spots

var bool bFirstplay;

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
	`log("Mapinfo:"@BDmapInfo@" Numero de rotas:"@BDmapInfo.getNumRotas());
    
    Caminhos.Add(BDmapInfo.getNumRotas());
	`log("Caminhos:"@Caminhos.Length);

    for(i=0;i<BDmapInfo.getNumRotas();i++)
    {
       `log("i="@i);
	   arrayAux.Length = 0;
    	
       foreach WorldInfo.AllNavigationPoints(class'BD_Path', pathAux)
       {
          `log("Path"@pathAux@"Nome do Path:"@pathAux.Nome);
       	  if(pathAux.Nome == Name("Caminho"@i))
		  {
			    arrayAux.AddItem(pathAux);
		  }
	   }
	   
	   Caminhos[i] = new (none) class'BD_Caminho';
	   Caminhos[i].setCaminho(arrayAux);
	   Caminhos[i].setIndex(0);

       `log("Tam Caminhos"@i@"="@Caminhos[i].tamCaminho());
    }
}

function SpawnBot(Vector SpawnLocation)
{
      //Configura localização de Spawn da Carroca
      SpawnLocation.z = SpawnLocation.z + 500;

      //Spawn e Configurção da Carroça da Carroca
      Car_FollowBot = Spawn(class'BD_CarrocaController',,,SpawnLocation);
      Car_FollowPawn = Spawn(class'BD_CarrocaPawn',,,SpawnLocation);
      Car_FollowBot.Possess(Car_FollowPawn,false);
      `log("Current Goal Inicial:"@self.Caminhos[indexRotas].getAtualPath());
      Car_FollowBot.CurrentGoal = self.Caminhos[indexRotas].getAtualPath();
      Car_Followpawn.InitialLocation = SpawnLocation;
	  //Car_FollowBot.FollowDistance = 250;
      Car_FollowPawn.SetPhysics(PHYS_Falling);

	  BD_IsoCameraPawn(Pawn).setFollowActor(Car_FollowPawn);

      //Seta true para dizer que bot foram 'spawned'
      BotSpawned = true;
}

function PlayerTick(float DeltaTime)
{
	
	local float dist;
	
	super.PlayerTick(DeltaTime);

	if(BotSpawned)
	{
		if(Car_FollowPawn != none)
		{
			dist = VSize(Car_FollowPawn.Location - Car_FollowBot.CurrentGoal.Location);
			`log("Dist="@dist);

			if(dist < 100)
			{
				`log("Dist<100");
				`log("Path Atual"@self.Caminhos[indexRotas].getAtualPath());
				if(self.Caminhos[indexRotas].getAtualPath() == Car_FollowBot.CurrentGoal && self.Caminhos[indexRotas].ultimoPath())
				{
					`log("Proxima Rota");

					if(proxIndexRota == -1)
					{
						indexRotas = self.Caminhos[indexRotas].getAtualPath().proximo;
					}
					else
					{
						indexRotas = proxIndexRota;
						proxIndexRota = -1;
					}
					Car_FollowBot.CurrentGoal = self.Caminhos[indexRotas].getAtualPath();
				}
				else
				{
					self.Caminhos[indexRotas].proximoPath();
					Car_FollowBot.CurrentGoal = self.Caminhos[indexRotas].getAtualPath();
				}
			}

			`log("CurrentGoal:"@Car_FollowBot.CurrentGoal);
		
		}
	}
	
	if (!BotSpawned)
    {
        `log("Spawn Bots");
    	SpawnBot(Pawn.Location);
        BotSpawned = true;
        BD_Pawn(Pawn).InitialLocation = Pawn.Location;
    }
}

DefaultProperties
{
	BotSpawned=false
	proxIndexRota=-1

}
