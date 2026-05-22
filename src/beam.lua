--- @module rkobo.beam
local beam = {}

-- class table
local Beam = {
}

function beam.new()
  local self = {}
  setmetatable(self, { __index = Beam })
  return self
end

return beam
