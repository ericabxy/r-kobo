local controls = {
  fire = false,
  up = false,
  down = false,
  left = false,
  right = false
}

function controls.dpad()
  return controls.up, controls.down, controls.left, controls.right
end

function love.joystickpressed(n, b)
  if b == 3 then
    love.load()
  elseif b == 4 then
    controls.up = true
  elseif b == 5 then
    controls.down = true
  elseif b == 6 then
    controls.left = true
  elseif b == 7 then
    controls.right = true
  end
end

function love.joystickreleased(n, b)
  if b == 4 then
    controls.up = false
  elseif b == 5 then
    controls.down = false
  elseif b == 6 then
    controls.left = false
  elseif b == 7 then
    controls.right = false
  end
end

if not lutro then
  function love.keypressed(key)
    if key == 'escape' then
      love.event.quit()
    elseif key == 'return' then
      love.load()
    elseif key == 'z' then
      controls.fire = true
    elseif key == 'up' then
      controls.up = true
    elseif key == 'down' then
      controls.down = true
    elseif key == 'left' then
      controls.left = true
    elseif key == 'right' then
      controls.right = true
    end
  end

  function love.keyreleased(key)
    if key == 'z' then
      controls.fire = false
    elseif key == 'up' then
      controls.up = false
    elseif key == 'down' then
      controls.down = false
    elseif key == 'left' then
      controls.left = false
    elseif key == 'right' then
      controls.right = false
    end
  end
end

return controls
