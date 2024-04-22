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

  function resetPosition()
    -- resets button position
    -- randomize height. lower is wider range
    local divFactor = 4 * math.random(-1, 1)
    local newHeight = interactButton:getParent():getHeight() / divFactor
    interactButton:setMarginTop(newHeight)
    interactButton:setMarginRight(0)
  end

  function detectOutOfBounds()
    -- take action once the button is leaving the window
    local maxMargin = interactButton:getParent():getWidth() - 100 -- offset
    if (interactButton:getMarginRight() > maxMargin) then
      resetPosition()
    end
  end

  local currentMargin = nil
  local moveButtonEvent = nil
  function moveButtonLeft()
    -- This function continuously moves the interact button left
    detectOutOfBounds() -- keep in window
    currentMargin = interactButton:getMarginRight()
    interactButton:setMarginRight(currentMargin + 5)
    moveButtonEvent = scheduleEvent(moveButtonLeft, 50) --50 ms
  end
  moveButtonLeft()

  interactButton.onClick = function ()
    resetPosition()
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