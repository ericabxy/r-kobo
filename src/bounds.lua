--- @module src.bounds
local bounds = {}

-- class table
local Bounds = {
  left = 0,
  top = 0,
  right = 320,
  bottom = 240,
}

function Bounds:Bounds(left, top, right, bottom)
  self.left = left
  self.top = top
  self.right = right
  self.bottom = bottom
end

function Bounds:wrap(x, y)
  if x > self.right then x = self.left
  elseif x < self.left then x = self.right
  end
  if y > self.bottom then y = self.top
  elseif y < self.top then y = self.bottom
  end
  return x, y
end

function bounds.new(...)
  local self = {}
  setmetatable(self, { __index = Bounds })
  self:Bounds(...)
  return self
end

return bounds
