class BD_SeqAct_SetProxRota extends SequenceAction;

var() int ProxRota;
var() BD_PlayerController Player;

event Activated()
{
	super.Activated();
	Player.proxIndexRota = ProxRota;
}

DefaultProperties
 {
 	// name that will apear in the Kismet Editor
 	ObjName="Set Prox Rota"
 	ObjCategory="Beer Defense"

 	// Expose the Amount pperty in Kismet
 	VariableLinks(0)=(ExpectedType=class'SeqVar_Object',LinkDesc="Player",PropertyName=Player)
    VariableLinks(1)=(ExpectedType=class'SeqVar_Int', LinkDesc="Prox Rota", PropertyName=ProxRota)
}
