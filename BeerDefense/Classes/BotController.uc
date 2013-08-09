//-----------------------------------------------------------
// Codigo Baseado no do Livro - "Beginning iOS 3D Unreal Games Development"
// Criado por Robert Chin
// Modificaçõoes feita para o Jogo "Beer Defense"
// Modificado por Igor Felga
// Criado em 11/08/2012 - 10:07
// Revisado por Fernando Ribeiro
// Data: 08/08/2013
//-----------------------------------------------------------

class BotController extends UDKBot;

var Actor CurrentGoal;
var Vector TempDest;
var float fFollowDistance;
var Actor TempGoal;
var bool bStop;

/**********************************
			* Eventos * 
***********************************/

event bool GeneratePathTo(Actor Goal, optional float WithinDistance, optional bool bAllowPartialPath)
{
       if( NavigationHandle == none )
       {
           return false;
       }

       // Clear cache and constraints (ignore recycling for the moment)
       NavigationHandle.PathConstraintList = none;
       NavigationHandle.PathGoalList = none;
       class'NavMeshPath_Toward'.static.TowardGoal( NavigationHandle, Goal );
       class'NavMeshGoal_At'.static.AtActor( NavigationHandle, Goal, WithinDistance, bAllowPartialPath );

       return NavigationHandle.FindPath();
}

protected event ExecuteWhatToDoNext()
{
      if (IsInState('Initial'))
      {
           GotoState('FollowTarget', 'Begin');
      }
      else
      {
           GotoState('FollowTarget', 'Begin');
      }
}

event WhatToDoNext()
{
      DecisionComponent.bTriggered = true;
}


/**********************************
			* Funções * 
***********************************/

function Stop()
{
	bStop = true;
}

function Go()
{	
	bStop = false;
}

/**********************************
			* States * 
***********************************/

state FollowTarget
{
	Begin:
	//WorldInfo.Game.Broadcast(self,"BotController-USING NAVMESH for FOLLOWTARGET STATE");
	if(!bStop)
	{
		// Move Bot to Target
		if (CurrentGoal != none)
		{
			if(GeneratePathTo(CurrentGoal))
			{
				NavigationHandle.SetFinalDestination(CurrentGoal.Location);
				if( NavigationHandle.ActorReachable(CurrentGoal) )
				{
					// then move directly to the actor
					MoveTo(CurrentGoal.Location, ,fFollowDistance);
				}
				else
				{
					// move to the first node on the path
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
				//give up because the nav mesh failed to find a path
				`warn("FindNavMeshPath failed to find a path!");
				//WorldInfo.Game.Broadcast(self,"FindNavMeshPath failed to find a path!, CurrentGoal = " @ CurrentGoal);
				MoveTo(Pawn.Location);
			}

			LatentWhatToDoNext();
		}
		else
		{
			MoveTo(Pawn.Location, CurrentGoal);  
		}
	}
}

auto state Initial
{
     Begin:
     LatentWhatToDoNext();
}

DefaultProperties
{
    CurrentGoal = None;
    fFollowDistance = 25;
	bStop = false;
}