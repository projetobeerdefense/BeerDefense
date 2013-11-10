class BD_BotController extends UDKBot;

var Actor CurrentGoal;
var Actor TempGoal;
var Vector vTempDest;
var float fFollowDistance;
var bool bStop;

event bool GeneratePathTo(Actor Goal, optional float WithinDistance, optional bool bAllowPartialPath)
{
	if( NavigationHandle == None )
	{
		return FALSE;
	}

	// Clear cache and constraints (ignore recycling for the moment)
	NavigationHandle.PathConstraintList = none;
	NavigationHandle.PathGoalList = none;
	class'NavMeshPath_Toward'.static.TowardGoal( NavigationHandle, Goal );
	class'NavMeshGoal_At'.static.AtActor( NavigationHandle, Goal, WithinDistance, bAllowPartialPath );

	return NavigationHandle.FindPath();
}

state FollowTarget
{
    Begin:
    //WorldInfo.Game.Broadcast(self,"BotController-USING NAVMESH for FOLLOWTARGET STATE");
	if(!bStop)
	{
		// Move Bot to Target
		if (CurrentGoal != None)
		{
			//WorldInfo.Game.Broadcast(self,self.CurrentGoal);
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
					if( NavigationHandle.GetNextMoveLocation(vTempDest, Pawn.GetCollisionRadius()) )
					{
						// suggest move preparation will return TRUE when the edge's
						// logic is getting the bot to the edge point
						// FALSE if we should run there ourselves
						if (!NavigationHandle.SuggestMovePreparation(vTempDest,self))
						{
								MoveTo(vTempDest);
						}
					}
				}
			}
		}
		else
		{
			//give up because the nav mesh failed to find a path
			`warn("FindNavMeshPath failed to find a path!");
			WorldInfo.Game.Broadcast(self,"FindNavMeshPath failed to find a path!, CurrentGoal = " @ CurrentGoal);
			MoveTo(Pawn.Location);
		}
		LatentWhatToDoNext(); 
	}
	else
	{
		MoveTo(Pawn.Location, CurrentGoal);  
	}
}

auto state Initial
{
    Begin:
    LatentWhatToDoNext();
}

event WhatToDoNext()
{
	DecisionComponent.bTriggered = true;
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

DefaultProperties
{
    CurrentGoal = None;
    fFollowDistance = 26;
	bStop = false;
}
