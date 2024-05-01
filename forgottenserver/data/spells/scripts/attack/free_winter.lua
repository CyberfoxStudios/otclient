local combats = {}
local SPELL_REPEATS = 6 -- if > 6 add to SCATTER3x3

function onGetFormulaValues(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 5.5) + 25
	local max = (level / 5) + (magicLevel * 11) + 50
	return -min, -max
end

for initializer = 1, SPELL_REPEATS do
	-- create a sequence of combats with different areas
	newCombat = Combat()
	newCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
	newCombat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
	newCombat:setArea(createCombatArea(SCATTER3X3[initializer]))
	function onGetFormulaValues(player, level, magicLevel)
		local min = (level / 5) + (magicLevel * 5.5) + 25
		local max = (level / 5) + (magicLevel * 11) + 50
		return -min, -max
	end
	newCombat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
	combats[initializer] = newCombat
end

function onCastSpell(creature, variant)
	-- recast the spell several times
	-- to increase the length and allow for new areas
	for counter = 1, SPELL_REPEATS do
		addEvent(function () 
			combats[counter]:execute(creature, variant)
		end, counter * 500) -- 500 ms == 0.5s
	end
end