jumpButton = nil

function init()
  g_ui.importStyle('jumpwindow')
  g_ui.importStyle('jumplinewindow')

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
  if questLogWindow then
    questLogWindow:destroy()
  end
end

function onGameQuestLog(quests)
  destroyWindows()

  questLogWindow = g_ui.createWidget('QuestLogWindow', rootWidget)
  local questList = questLogWindow:getChildById('questList')

  for i,questEntry in pairs(quests) do
    local id, name, completed = unpack(questEntry)

    local questLabel = g_ui.createWidget('QuestLabel', questList)
    questLabel:setOn(completed)
    questLabel:setText(name)
  end

  questLogWindow.onDestroy = function()
    questLogWindow = nil
  end

  questList:focusChild(questList:getFirstChild())
end