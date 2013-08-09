//-----------------------------------------------------------
// Criado por Igor Felga
// Criado em 11/08/2012 - 22:01
// Classe "BD_CarrocaController" - Para o Jogo Beer Defense
// Revisado por Fernando Ribeiro
// Data: 08/08/2013
//-----------------------------------------------------------

//-----------------------------------------------------------
// @@ Classe responsavel pela IA da Carroça
//-----------------------------------------------------------

class BD_CarrocaController extends BotController;

var int iCaminhoIndex;          // Variavel que controla qual é o destino atual Ponto
var actor auxGoal;             // Variavel auxiliar para a troca de destino
var bool bChangeGoal;           // Variavel de controle para dizer se é o momento da troca
var bool bStatusWalking;

/**********************************
			* Funções * 
***********************************/

function Tick(float DeltaTime)
{
	if(self.pawn.health < 2)
	{
		`log("entrando");
		self.Stop();
		bStatusWalking = false;
		gotostate('FollowTarget','Begin');
	}
	else 
	{
		go();
	}

	bStatusWalking = true;
}

/**********************************
			* States * 
***********************************/

//@@@@@ -------- Estado Responsavel em dizer para onde a carroça deve ir -------- @@@@@
state FollowTarget
{
		Begin:
		//WorldInfo.Game.Broadcast(self,"BotController-USING NAVMESH for FOLLOWTARGET STATE");
		if(!bStop)
		{
			//Verifica se é o momento correto de trocar de destino
			if(bChangeGoal)
			{
				self.CurrentGoal = self.auxGoal;  // Destino atual recebe o valor auxiliar
				self.bChangeGoal = false;          // Seta falso para na proxima interação saber que não precisa trocar
			}

			// Move a carroça até o destino
			if (CurrentGoal != none)
			{
				if(GeneratePathTo(CurrentGoal))
				{
					NavigationHandle.SetFinalDestination(CurrentGoal.Location);
					if( NavigationHandle.ActorReachable(CurrentGoal) )
					{
						// Então move diretamente para o destino
						MoveTo(CurrentGoal.Location, ,fFollowDistance);
					}
					else
					{
						// Move para o primeiro nó do destino (esse nó não tem relação nenhuma com os PathNodes)
						if( NavigationHandle.GetNextMoveLocation(TempDest, Pawn.GetCollisionRadius()) )
						{
								// suggest move preparation will return TRUE when the edge's
								// logic is getting the bot to the edge point
								// FALSE if we should run there ourselves
								if (!NavigationHandle.SuggestMovePreparation(TempDest,self))
								{
										MoveTo(TempDest);
								}
						}
					}
				}
				else
				{
					//Desiste pois não foi possivel a Navmesh criar um caminho
					`warn("FindNavMeshPath failed to find a path!");
					//WorldInfo.Game.Broadcast(self,"FindNavMeshPath failed to find a path!, CurrentGoal = " @ CurrentGoal);
					`log(self@"FindNavMeshPath failed to find a path!, CurrentGoal = " @ CurrentGoal);
					MoveTo(Pawn.Location);
				}
			}

			LatentWhatToDoNext();
		}
		else
		{
			MoveTo(Pawn.Location, CurrentGoal);
		}
}

DefaultProperties
{
    iCaminhoIndex = 0
    bChangeGoal = false
	bStatusWalking = true
}