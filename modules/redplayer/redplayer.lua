function init()
  g_keyboard.bindKeyDown('R', redPlayer)
  g_keyboard.bindKeyUp('R', whitePlayer)
end

function terminate()
  --undo bindings
  g_keyboard.unbindKeyDown('R')
  g_keyboard.unbindKeyUp('R')
end

function redPlayer()
  -- changes player color
  local player = g_game.getLocalPlayer()
  if player then
    player:setOutfitColor('#f55e5e', 0) -- red
  end
end

function whitePlayer()
  -- changes player color
  local player = g_game.getLocalPlayer()
  if player then
    player:setOutfitColor('#ffffff', 0) -- red
  end
end