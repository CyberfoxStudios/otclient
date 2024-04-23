function init()
  toggleColor()
end

function terminate()
end

function toggleColor()
  -- changes player color
  local player = g_game.getLocalPlayer()
  if player then
    player:setOutfitColor('#f55e5e', 0) -- red
  end
end
