SMODS.Atlas({
    key = "ghost",
    path = "j_cl_ghost.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "ghost",
    config = { extra = { money = 0, money_mod = 2 } },
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'ghost',
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable and context.consumeable.ability.set == 'Spectral' and not context.blueprint then
            card_eval_status_text(card, 'extra', nil, nil, nil, {
                message = localize('k_upgrade_ex'),
                colour = G.C.GOLD,
            })
            card.ability.extra.money = card.ability.extra.money + card.ability.extra.money_mod
        end
    end,

    calc_dollar_bonus = function(self, card)
		local bonus = card.ability.extra.money
		if bonus > 0 then return bonus end
	end,

    loc_vars = function(self, info_queue, card)
        return { vars = {
            card.ability.extra.money,
            card.ability.extra.money_mod,
        }}
    end,
}
