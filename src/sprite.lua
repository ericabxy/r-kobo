--- @module src.sprite
local sprite = {}

-- class table
local Sprite = {
  texture = false,
  quad = false,
  ox = 0,
  oy = 0
}

function Sprite:Sprite(texture, quad)
  self.texture = texture
  self.quad = quad
end

function Sprite:render(x, y)
  local x, y = x and x or 0, y and y or 0
  love.graphics.draw(self.texture, self.quad, x + self.ox, y + self.oy)
end

function sprite.new(...)
  local self = {}
  setmetatable(self, { __index = Sprite })
  self:Sprite(...)
  return self
end

return sprite
