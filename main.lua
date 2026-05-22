local controls = require('controls')
local graphics = require('graphics')
local beam = require('src.beam')
local enemy = require('src.enemy')
local myship = require('src.myship')
local radar = require('src.radar')
local score = require('src.score')
local screen = require('src.screen')

local chips_t
local enemies_t
local radar0 = radar.new()
local score0 = score.new()
score0.font = graphics.imagefont0
screen0 = screen.new()
screen0:init()

function love.load()
  chips_t = {}
  enemies_t = {}
  ship0 = myship.new(graphics.texture0)
  for x = 1, 256 do
    local e = enemy.new(graphics.texture0)
    e.x = love.math.random(512)
    e.y = love.math.random(1536)
    if ((e.x < 80 or e.x > 176) or (e.y < 96 or e.y > 160)) and
        ((e.x < 96 or e.x > 160) or (e.y < 80 or e.y > 176)) then
      table.insert(enemies_t, e)
      table.insert(chips_t, e)
    end
  end
end

function love.update(dt)
  ship0:change(controls.dpad( ))
  ship0:move(dt)
  screen0.x = ship0.x - 112
  screen0.y = ship0.y - 112
  radar0.blips_yellow[1] = {x = ship0.x, y = ship0.y}
  for _, enemy in ipairs(enemies_t) do
    enemy:update(dt)
    if ship0:is_touching(enemy) then
      ship0:destroy()
    end
  end
end

function love.draw()
  if not lutro then love.graphics.scale(2.5, 2.5) end
  for _, texture in ipairs(screen0.stars) do
    love.graphics.draw(texture, -screen0.x, -screen0.y)
  end
  for _, chip in ipairs(chips_t) do
    chip:render( screen0.x, screen0.y )
    chip:render( screen0.x - 512, screen0.y )
    chip:render( screen0.x, screen0.y - 1536 )
    chip:render( screen0.x - 512, screen0.y - 1536 )
  end
  ship0:render( screen0.x, screen0.y )
  love.graphics.setColor(graphics.black)
  love.graphics.rectangle('fill', 240, 0, 80, 240)
  love.graphics.setColor(graphics.white)
  score0:render()
  radar0:render()
end
