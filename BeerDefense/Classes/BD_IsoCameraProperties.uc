class BD_IsoCameraProperties extends Object
	HideCategories(Object);

var(Camera) float fCamOffsetDistance  <DisplayName=Distancia Inicial>;    //Distancia Inicial da camera para o jogador (em UnrealUnits)
var(Camera) float fCamMinDistance     <DisplayName=Distancia Minima>;     //Distancia minima da camera para o jogador (em UnrealUnits)
var(Camera) float fCamMaxDistance     <DisplayName=Distancia Maxima>;     //Distancia maxima da camera para o jogador (em UnrealUnits)
var(Camera) float fCamZoomTick        <DisplayName=Velocidade Zoom>;      //Velocidade para movimentar o zoom in/out
var(Camera) float fPitchAng           <DisplayName=Angulo da Camera>;     //Valor do angulo desejado, em graus

DefaultProperties
{
	fCamMinDistance = 100.0
	fCamMaxDistance = 1000.0
   	fCamOffsetDistance=500.0
	fCamZoomTick=50.0
	fPitchAng=37.5
}
