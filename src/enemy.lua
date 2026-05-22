--- @module rkobo.enemy
local hitbox = require('src.hitbox')
local sprite = require('src.sprite')

local enemy = {}

-- constants
local BEAM = 'beam'

-- class table
local Enemy = {
  animation_frame = 0,
  animation_timer = 0,
  rkobo_type = BEAM,
  x = 0,
  y = 0,
}

function Enemy:Enemy(texture)
  local quad = love.graphics.newQuad(0, 0, 16, 16, 256, 128)
  self.sprite = sprite.new(texture, quad)
  self.hitbox = hitbox.new(1, 1, 7, 7)
end

function Enemy:animate_beam(dt)
  self.animation_timer = self.animation_timer + dt
  if self.animation_timer * 1000 > 30 then
    self.animation_frame = (self.animation_frame + 1) % 8
    self.animation_timer = 0
    self.sprite.quad:setViewport(self.animation_frame * 16, 0, 16, 16)
  end
end

function Enemy:render(x, y)
  local x, y = x and x or 0, y and y or 0
  self.sprite:render(self.x - x, self.y - y)
end

function Enemy:update(dt)
  if self.rkobo_type == BEAM then
    self:animate_beam(dt)
  end
end

function enemy.new(...)
  local self = {}
  setmetatable(self, { __index = Enemy })
  self:Enemy(...)
  return self
end

return enemy
