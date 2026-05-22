--- @module rkobo.radar
local radar = {}

-- class table
local Radar = {
  x = 240,
  y = 120,
  width = 80,
  height = 120
}

Radar.color0 = lutro and {85, 85, 85} or {.33, .33, .33}
Radar.green = lutro and {0, 170, 0} or {0, .66, 0}
Radar.red = lutro and {170, 0, 0} or {.66, 0, 0}
Radar.yellow = lutro and {170, 170, 0} or {.66, .66, 0}
Radar.blips_green = {}
Radar.blips_red = {}
Radar.blips_yellow = {}

function Radar:render()
  love.graphics.setColor(self.color0)
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
  love.graphics.setColor(self.green)
  for _, blip in ipairs(self.blips_green) do
    self:render_blip(blip.x, blip.y)
  end
  love.graphics.setColor(self.red)
  for _, blip in ipairs(self.blips_red) do
    self:render_blip(blip.x, blip.y)
  end
  love.graphics.setColor(self.yellow)
  for _, blip in ipairs(self.blips_yellow) do
    self:render_blip(blip.x, blip.y)
  end
end

function Radar:render_blip(x, y)
  local x = math.floor(x / 6.4) % 80
  local y = math.floor(y / 12.8) % 120
  love.graphics.rectangle('fill', self.x + x, self.y + y, 2.5, 1)
end

function radar.new()
  local self = {}
  setmetatable(self, { __index = Radar })
  return self
end

return radar
