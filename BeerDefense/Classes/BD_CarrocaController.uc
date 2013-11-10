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

DefaultProperties
{
    iCaminhoIndex = 0
}