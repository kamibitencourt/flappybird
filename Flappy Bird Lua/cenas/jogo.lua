local composer = require("composer")

local scene = composer.newScene()

function scene:create( event )
  local cenaJogo = self.view


-- DECLARÇÃO DA BIBLIOTECA DE FISICA
local physics = require("physics")
physics.start()
physics.setGravity( 0, 80 )
physics.setDrawMode( "hybrid" )


-- DECLARAÇÃO DE VARIAVEIS
local distanciaCanos = y
local velocidadeCanos = 4000
local forcaPulo = -700
local vivo = true

-- DECLARAÇÃO DOS OBJETOS
local fundo = display.newImageRect(cenaJogo,fundoRandomico, x, y)
fundo.x = x*0.5
fundo.y = y*0.5

local passaro = display.newImageRect(cenaJogo,passaroRandomico, x*0.12, y*0.08 )
passaro.x = x*0.3
passaro.y = y*0.1
physics.addBody(passaro)
passaro.isBullet = true
passaro.isFixedRotation = true

local chao = display.newImageRect(cenaJogo,imagens.chao, x, y*0.2 )
chao.x = x*0.5
chao.y = y*0.9
physics.addBody(chao, 'static')

-- DECLARAÇÃO DA PONTUAÇÃO
local textoPontos = display.newText(cenaJogo,pontos, x*0.5, y*0.1, fontePrincipal, 150)

-- DECLARAÇÃO DAS FUNCÕES
local function criaCanos()
  if vivo == true then
    local canoBaixo = display.newImageRect(cenaJogo, canoRandomico, x*0.2, y*0.8 )
    canoBaixo.x = x*1.2
    canoBaixo.y = math.random(y*0.6, y*1.15)
    physics.addBody(canoBaixo, 'static')
    canoBaixo.id = "canoBaixoID"

    local canoCima = display.newImageRect(cenaJogo, canoRandomico, x*0.2, y*0.8 )
    canoCima.rotation = 180
    canoCima.x = canoBaixo.x
    canoCima.y = canoBaixo.y - distanciaCanos
    physics.addBody(canoCima, 'static')
    canoCima.id = "canoCimaID"

    local sensor = display.newCircle(cenaJogo,0,0,80)
    sensor.x = canoBaixo.x
    sensor.y = canoBaixo.y - distanciaCanos*0.5
    sensor.alpha = 0
    physics.addBody(sensor, 'static' )
    sensor.isSensor = true
    sensor.id = "sensorID"
    -- o id é utilizado para adicionar um identificador global para este objeto, tornando acessivel fora da função para verificar colisão

    local function transicao(objeto)
      transition.to( objeto, {
        time = velocidadeCanos,
        x = -x*0.2,
        onComplete = function()
          display.remove( objeto )
        end
      })
    end
    transicao(sensor)
    transicao(canoBaixo)
    transicao(canoCima)

  end
end
timer.performWithDelay( 2000, criaCanos, 0 )


local function voar(event)
  if vivo == true then
    if event.phase == "began" then
      audio.play( audioVoar )
      passaro:setLinearVelocity(0, forcaPulo)
    end
  end
end
Runtime:addEventListener("touch", voar)

function reiniciar()

  audio.play( audioMorte )

  local gameOver = display.newImageRect(cenaJogo, imagens.fim, 0, 0)
  gameOver.x = x*0.5
  gameOver.y = y*0.5
  transition.to( gameOver, {
    time = 200,
    width = x*0.8,
    height = x*0.2,
    rotation = 360
  })
  composer.setVariable( "finalScore", pontos )

  timer.performWithDelay( 3000, function()
    pontos = 0
    display.remove( passaro )
    composer.removeScene( "cenas.jogo" )
    composer.gotoScene( "cenas.menu" )
  end )

end

local function verificaColisao(event)
  if event.phase == "began" then
    if (event.object1 == passaro and event.object2 == chao) then
      if vivo == true then
        reiniciar()
        vivo = false
      end
     
    elseif event.object1 == passaro and event.object2.id == "sensorID" or event.object2 == passaro and event.object1.id == "sensorID"  then
      pontos = pontos + 1
      textoPontos.text = pontos
      audio.play( audioPonto )
    
    elseif (event.object1 == passaro and event.object2.id == "canoBaixoID") or (event.object2 == passaro and event.object1.id == "canoBaixoID") or (event.object1 == passaro and event.object2.id == "canoCimaID") or (event.object2 == passaro and event.object1.id == "canoCimaID") then
      if vivo == true then
        reiniciar()
        vivo = false
      end
    end
  end
end
Runtime:addEventListener("collision", verificaColisao)



end
scene:addEventListener( "create", scene )
return scene
