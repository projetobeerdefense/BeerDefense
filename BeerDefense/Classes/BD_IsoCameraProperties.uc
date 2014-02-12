class BD_IsoCameraProperties extends Object
	HideCategories(Object);

var(Camera) float fCamOffsetDistance;        //Distancia da camera para o jogador (em UnrealUnits)
var(Camera) float fCamMinDistance;           //Distancia minima da camera para o jogador (em UnrealUnits)
var(Camera) float fCamMaxDistance;           //Distancia maxima da camera para o jogador (em UnrealUnits)
var(Camera) float fCamZoomTick;              //Quantidade para movimentar o zoom in/out
var(Camera) float fPitchAng;                 //Valor do angulo desejado, em graus

DefaultProperties
{
	fCamMinDistance = 100.0
	fCamMaxDistance = 8000.0
   	fCamOffsetDistance=500.0
	fCamZoomTick=50.0
	fPitchAng=37.5
}
