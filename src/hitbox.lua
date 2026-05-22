--- @module src.hitbox
local hitbox = {}

-- class table
local HitBox = {
  ox = 0,
  oy = 0,
}

function HitBox:HitBox(x1, y1, x2, y2)
  self.minx = x1
  self.miny = y1
  self.maxx = x2
  self.maxy = y2
end

function HitBox:set(x, y)
  self.ox = x
  self.oy = y
end

function HitBox:test(o)
  local aminx = self.ox + self.minx
  local amaxx = self.ox + self.maxx
  local aminy = self.oy + self.miny
  local amaxy = self.oy + self.maxy
  local bminx = o.ox + o.minx
  local bmaxx = o.ox + o.maxx
  local bminy = o.oy + o.miny
  local bmaxy = o.oy + o.maxy
  return aminx <= bmaxx and amaxx >= bminx and aminy <= bmaxy and amaxy >= bminy
end

function hitbox.new(...)
  local self = {}
  setmetatable(self, { __index = HitBox })
  self:HitBox(...)
  return self
end

return hitbox
