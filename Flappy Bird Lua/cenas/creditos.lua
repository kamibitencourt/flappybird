local composer = require("composer")

local scene = composer.newScene()

function scene:create( event )
  local cenaCreditos = self.view

  local fundo = display.newImageRect(cenaCreditos, fundoRandomico, x, y )
  fundo.x = x*0.5
  fundo.y = y*0.5

  local texto = display.newText(cenaCreditos, "Creditos", x*0.5, y*0.5, fontePrincipal, 80 )


end
scene:addEventListener( "create", scene )
return scene