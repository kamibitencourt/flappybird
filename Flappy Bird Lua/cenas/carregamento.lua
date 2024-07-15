local composer = require("composer")

local scene = composer.newScene()

function scene:create( event )
  local cenaCarregamento = self.view

  local fundo = display.newImageRect(cenaCarregamento ,fundoRandomico, x, y)
  fundo.x = x*0.5
  fundo.y = y*0.5

  function proximaCena()
    composer.gotoScene( "cenas.menu", {
      time = 500,
      effect = "slideLeft"
    })
  end
  timer.performWithDelay( 2000, proximaCena)


end
scene:addEventListener( "create", scene )
return scene

