--- @module rkobo.score
local score = {}

-- class table
local Score = {
  x = 240,
  y = 0,
  score = 0,
  stage = 0,
  ships = 0
}

function Score:render()
  love.graphics.setFont(self.font)
  love.graphics.print('SCORE', self.x, 0)
  love.graphics.print(self.score, self.x, 8)
  love.graphics.print('STAGE', self.x, 16)
  love.graphics.print(self.stage, self.x, 24)
  love.graphics.print('SHIPS', self.x, 32)
  love.graphics.print(self.ships, self.x, 40)
end

function score.new()
  local self = {}
  setmetatable(self, { __index = Score })
  return self
end

return score
