if not lutro then love.graphics.setDefaultFilter('nearest', 'nearest') end

local graphics = {}

graphics.black = {0, 0, 0}
graphics.imagefont0 = love.graphics.newImageFont(
  'share/imagefont-cellphone_white.png',
  '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ',
  -1
)
graphics.ship0 = love.graphics.newQuad(0, 48, 16, 16, 256, 128)
graphics.beam0 = love.graphics.newQuad(0, 0, 16, 16, 256, 128)
graphics.texture0 = love.graphics.newImage('share/xkp256.png')
graphics.white = lutro and {255, 255, 255} or {1, 1, 1}

return graphics
