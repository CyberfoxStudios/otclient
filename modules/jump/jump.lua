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

  local currentMargin = nil
  local moveButtonEvent = nil
  function moveButtonLeft()
    -- This function continuously moves the interact button left
    currentMargin = interactButton:getMarginRight()
    interactButton:setMarginRight(currentMargin + 5)
    moveButtonEvent = scheduleEvent(moveButtonLeft, 50) --50 ms
  end
  moveButtonLeft()

  -- Set onClick function to move the button left
  interactButton.onClick = function()
    interactButton:setMarginTop(interactButton:getParent():getHeight() / 10) 
    interactButton:setMarginRight(0)
  end

  interactButton.onDestroy = function()
    if moveButtonEvent then
      -- remove scheduled button reference
      removeEvent(moveButtonEvent)
    end
    interactButton = nil
  end

  jumpWindow.onDestroy = function()
    jumpWindow = nil
  end
end