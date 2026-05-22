--- @module rkobo.screen
local screen = {}

-- class table
local Screen = {
  x = 0,
  y = 0,
  width = 512,
  height = 1536,
  star_colors = {},
  stars = {},
}

Screen.star_colors[1] = lutro and {105, 105, 105} or {.41, .41, .41}
Screen.star_colors[2] = lutro and {127, 127, 127} or {.50, .50, .50}
Screen.star_colors[3] = lutro and {168, 168, 168} or {.66, .66, .66}
Screen.star_colors[4] = lutro and {191, 191, 191} or {.75, .75, .75}
Screen.star_colors[5] = lutro and {212, 212, 212} or {.83, .83, .83}
Screen.star_colors[6] = lutro and {219, 219, 219} or {.86, .86, .86}
Screen.star_colors[7] = lutro and {245, 245, 245} or {.96, .96, .96}

function Screen:init()
  self.stars = {}
  for _, color in ipairs(self.star_colors) do
    local canvas = love.graphics.newCanvas(self.width + 240, self.height + 240)
    love.graphics.setCanvas(canvas)
    love.graphics.setColor(color)
    for x = 0, 2000 do
      local x = love.math.random(self.width)
      local y = love.math.random(self.height)
      if ((x < 80 or x > 176) or (y < 96 or y > 160)) and
          ((x < 96 or x > 160) or (y < 80 or y > 176)) then
        love.graphics.rectangle('fill', x, y, 1, 1)
        love.graphics.rectangle('fill', x + self.width, y, 1, 1)
        love.graphics.rectangle('fill', x, y + self.height, 1, 1)
        love.graphics.rectangle('fill', x + self.width, y + self.height, 1, 1)
      end
    end
    table.insert(self.stars, canvas) 
  end
  love.graphics.setCanvas()
end

function screen.new()
  local self = {}
  setmetatable(self, { __index = Screen })
  return self
end

return screen
