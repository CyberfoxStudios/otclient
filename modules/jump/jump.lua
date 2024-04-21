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

  -- Set onClick function to move the button left
  interactButton.onClick = function()
    local currentMargin = interactButton:getMarginLeft()
    interactButton:setMarginLeft(currentMargin - 10)
  end

  interactButton.onDestroy = function()
    interactButton = nil
  end

  jumpWindow.onDestroy = function()
    jumpWindow = nil
  end
end