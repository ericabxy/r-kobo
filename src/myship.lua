--- @module rkobo.myship
local bounds = require('src.bounds')  
local hitbox = require('src.hitbox')
local sprite = require('src.sprite')

local myship = {}

-- constants
local BEAM = 'beam'
local BOOM = 'boom'
local SHIP = 'ship'

-- class module
local MyShip = {
  animation_frame = 0,
  animation_timer = 0,
  rkobo_type = SHIP,
  direction = 1,
  dx = 0,
  dy = -1,
  x = 100,
  y = 100,
}

function MyShip:MyShip(texture)
  local quad = love.graphics.newQuad(0, 48, 16, 16, 256, 128)
  self.sprite = sprite.new(texture, quad)
  self.hitbox = hitbox.new(5, 5, 13, 13)
  self.bounds = bounds.new(120, 120, 512 + 120, 1536 + 120)
end

function MyShip:animate_boom(dt)
  self.animation_timer = self.animation_timer + dt
  if self.animation_timer * 1000 > 90 and self.animation_frame < 7 then
    self.animation_frame = (self.animation_frame + 1)
    self.animation_timer = 0
    self.sprite.quad:setViewport(self.animation_frame * 16, 16, 16, 16)
  end
end

function MyShip:change(up, down, left, right)
  up = up and 1 or 0
  down = down and 1 or 0
  left = left and 1 or 0
  right = right and 1 or 0
  local lr = left - right
  local ud = up - down
  if lr > 0 then
    if ud > 0 then self.direction = 8
    elseif ud < 0 then self.direction = 6
    else self.direction = 7
    end
  elseif lr < 0 then
    if ud > 0 then self.direction = 2
    elseif ud < 0 then self.direction = 4
    else self.direction = 3
    end
  else
    if ud > 0 then self.direction = 1
    elseif ud < 0 then self.direction = 5
    end
  end
end

function MyShip:destroy()
  if self.rkobo_type == BOOM then return end
  self.animation_timer = 0
  self.animation_frame = 0
  self.rkobo_type = BOOM
end

function MyShip:is_touching(o)
  self.hitbox:set(self.x % 512, self.y % 1536)
  o.hitbox:set(o.x, o.y)
  return self.hitbox:test(o.hitbox)
end

function MyShip:move(dt)
  if self.rkobo_type == BOOM then
    self:animate_boom(dt)
    return
  end
  local speed = 25 * dt
  local x = -16 + self.direction * 16
  local y = self.rkobo_type == BEAM and 32 or 48 
  self.sprite.quad:setViewport(x, y, 16, 16)
  if self.direction == 1 then
    self.y = self.y - 3 * speed
  elseif self.direction == 2 then
    self.y = self.y - 2 * speed
    self.x = self.x + 2 * speed
  elseif self.direction == 3 then
    self.x = self.x + 3 * speed
  elseif self.direction == 4 then
    self.x = self.x + 2 * speed
    self.y = self.y + 2 * speed
  elseif self.direction == 5 then
    self.y = self.y + 3 * speed
  elseif self.direction == 6 then
    self.y = self.y + 2 * speed
    self.x = self.x - 2 * speed
  elseif self.direction == 7 then
    self.x = self.x - 3 * speed
  elseif self.direction == 8 then
    self.x = self.x - 2 * speed
    self.y = self.y - 2 * speed
  end
  self.x, self.y = self.bounds:wrap(self.x, self.y)
end

function MyShip:render(x, y)
  local x, y = x and x or 0, y and y or 0
  self.sprite:render(self.x - x, self.y - y)
end

function myship.new(...)
  local self = {}
  setmetatable(self, { __index = MyShip })
  self:MyShip(...)
  return self
end

return myship
