jumpButton = nil

function init()
  g_ui.importStyle('jumpwindow')

  jumpButton = modules.client_topmenu.addLeftGameButton('jumpButton', tr('Jump'), '/images/topbuttons/jump', function() g_game.requestQuestLog() end)

  connect(g_game, { onQuestLog = onGameQuestLog,
                    onGameEnd = destroyWindows})
end

function terminate()
  disconnect(g_game, { onQuestLog = onGameQuestLog,
                       onGameEnd = destroyWindows})

  destroyWindows()
  jumpButton:destroy()
end

function destroyWindows()
  if jumpWindow then
    jumpWindow:destroy()
  end
end

function onGameQuestLog(quests)
  destroyWindows()

  jumpWindow = g_ui.createWidget('JumpWindow', rootWidget)
  local questList = jumpWindow:getChildById('questList')

  for i,questEntry in pairs(quests) do
    local id, name, completed = unpack(questEntry)

    local questLabel = g_ui.createWidget('JumpLabel', questList)
    questLabel:setOn(completed)
    questLabel:setText(name)
  end

  jumpWindow.onDestroy = function()
    jumpWindow = nil
  end

  questList:focusChild(questList:getFirstChild())
end