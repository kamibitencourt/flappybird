
x = display.contentWidth
y = display.contentHeight

imagens = {
  chao = "recursos/imagens/base.png",
  inicio = "recursos/imagens/start.png",
  fim = "recursos/imagens/gameover.png",
  fundo = {
    "recursos/imagens/background-day.png",
    "recursos/imagens/background-night.png"
  },
  cano = {
    "recursos/imagens/pipe-green.png",
    "recursos/imagens/pipe-red.png"
  },
  passaro = {
    "recursos/imagens/bluebird.png",
    "recursos/imagens/redbird.png",
    "recursos/imagens/yellowbird.png"
  }
}

fundoRandomico = imagens.fundo[math.random(1,2)]
canoRandomico = imagens.cano[math.random(1,2)]
passaroRandomico = imagens.passaro[math.random(1,3)]

pontos = 0

fontePrincipal = "recursos/fontes/PUSAB___.otf"

audioMusica = audio.loadStream( "recursos/audios/music.mp3" )
audioMorte = audio.loadSound( "recursos/audios/die.mp3" )
audioVoar = audio.loadSound( "recursos/audios/wing.mp3" )
audioPonto = audio.loadSound( "recursos/audios/point.mp3" )
audioTransicao = audio.loadSound( "recursos/audios/swoosh.mp3" )


local composer = require("composer")

composer.gotoScene("cenas.carregamento")

