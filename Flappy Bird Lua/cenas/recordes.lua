local composer = require("composer")

local scene = composer.newScene()

function scene:create( event )
  local cenaRecordes = self.view

  local fundo = display.newImageRect(cenaRecordes, fundoRandomico, x, y )
  fundo.x = x*0.5
  fundo.y = y*0.5



  


end
scene:addEventListener( "create", scene )
return scene