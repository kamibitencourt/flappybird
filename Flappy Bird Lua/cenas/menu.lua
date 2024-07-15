local composer = require("composer")

local scene = composer.newScene()

function scene:create( event )
  local cenaMenu = self.view

  audio.play( audioMusica, {channel = 32, loops = -1} )
  audio.setVolume( 0.3, {channel = 32} )

  local fundo = display.newImageRect(cenaMenu, fundoRandomico, x, y )
  fundo.x = x*0.5
  fundo.y = y*0.5

  local titulo = display.newText(cenaMenu, "MENU", x*0.5, y*0.2, fontePrincipal, 100 )

  local textoJogar = display.newText(cenaMenu, "JOGAR", x*0.5, y*0.4, fontePrincipal, 100 )

  local textoRecordes = display.newText(cenaMenu, "RECORDES", x*0.5, y*0.5, fontePrincipal, 100 )

  local textoCreditos = display.newText(cenaMenu, "CREDITOS", x*0.5, y*0.6, fontePrincipal, 100 )

  local textoSair = display.newText(cenaMenu, "SAIR", x*0.5, y*0.7, fontePrincipal, 100 )

  local efeitoCena = {
    time = 500,
    effect = "slideLeft"
  }

  function jogar(event)
    if event.phase == "began" then
      audio.play( audioTransicao )
      composer.gotoScene("cenas.jogo", efeitoCena )
    end
  end
  textoJogar:addEventListener("touch", jogar)

  function recordes(event)
    if event.phase == "began" then
      audio.play( audioTransicao )
      composer.gotoScene("cenas.recordes", efeitoCena )
    end
  end
  textoRecordes:addEventListener("touch", recordes)

  function creditos(event)
    if event.phase == "began" then
      audio.play( audioTransicao )
      composer.gotoScene("cenas.creditos", efeitoCena )
    end
  end
  textoCreditos:addEventListener("touch", creditos)

  function sair(event)
    if event.phase == "began" then
      native.requestExit()
    end
  end
  textoSair:addEventListener("touch", sair)

  
end
scene:addEventListener( "create", scene )
return scene