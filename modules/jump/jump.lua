jumpButton = nil
interactButton = nil

function init()
  g_ui.importStyle('jumpwindow')

  jumpButton = modules.client_topmenu.addLeftGameButton('jumpButton', tr('Jump'), '/images/topbuttons/jump', function() onGameJump() end)

end

function terminate()
  destroyWindows()
  jumpButton:destroy()
end

function destroyWindows()
  if jumpWindow then
    jumpWindow:destroy()
  end
end

function onGameJump()
  destroyWindows()

  jumpWindow = g_ui.createWidget('JumpWindow', rootWidget)
  interactButton = jumpWindow:recursiveGetChildById('interactButton')

  function moveButtonLeft()
    -- This function continuously moves the interact button left
    local currentMargin = interactButton:getMarginRight()
    interactButton:setMarginRight(currentMargin + 5)
    scheduleEvent(moveButtonLeft, 50) --100 ms
  end
  moveButtonLeft()

  -- Set onClick function to move the button left
  interactButton.onClick = function() 
    interactButton:destroy()
  end

  interactButton.onDestroy = function()
    interactButton = nil
  end

  jumpWindow.onDestroy = function()
    jumpWindow = nil
  end
end