-- redplayer will color the player red
-- when holding ctrl + arrow key

-- start and end functions
function init()
  bindArrowKeys(redPlayer, whitePlayer)
end

function terminate()
  unbindArrowKeys()
end

-- keybind functions
function bindArrowKeys(downFunc, upFunc)
  g_keyboard.bindKeyDown('Ctrl+Up', downFunc)
  g_keyboard.bindKeyUp('Ctrl+Up', upFunc)
  g_keyboard.bindKeyDown('Ctrl+Down', downFunc)
  g_keyboard.bindKeyUp('Ctrl+Down', upFunc)
  g_keyboard.bindKeyDown('Ctrl+Left', downFunc)
  g_keyboard.bindKeyUp('Ctrl+Left', upFunc)
  g_keyboard.bindKeyDown('Ctrl+Right', downFunc)
  g_keyboard.bindKeyUp('Ctrl+Right', upFunc)
end

function unbindArrowKeys()
  g_keyboard.unbindKeyDown('Ctrl+Up')
  g_keyboard.unbindKeyUp('Ctrl+Up')
  g_keyboard.unbindKeyDown('Ctrl+Down')
  g_keyboard.unbindKeyUp('Ctrl+Down')
  g_keyboard.unbindKeyDown('Ctrl+Left')
  g_keyboard.unbindKeyUp('Ctrl+Left')
  g_keyboard.unbindKeyDown('Ctrl+Right')
  g_keyboard.unbindKeyUp('Ctrl+Right')
end

-- change player color functions
function redPlayer()
  local player = g_game.getLocalPlayer()
  if player then
    player:setOutfitColor('#f55e5e', 0) -- red
  end
end

function whitePlayer()
  local player = g_game.getLocalPlayer()
  if player then
    player:setOutfitColor('#ffffff', 0) -- white
  end
end