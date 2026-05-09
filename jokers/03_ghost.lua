SMODS.Atlas({
    key = "ghost",
    path = "j_cl_ghost.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "ghost",
    config = { extra = { money_mod = 2 } },
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

    calc_dollar_bonus = function(self, card)
		local bonus = G.GAME.consumeable_usage_total
            and G.GAME.consumeable_usage_total.spectral * card.ability.extra.money_mod
            or 0
		if bonus > 0 then return bonus end
	end,

    loc_vars = function(self, info_queue, card)
        return { vars = {
            G.GAME.consumeable_usage_total
                and G.GAME.consumeable_usage_total.spectral * card.ability.extra.money_mod
                or 0,
            card.ability.extra.money_mod,
        }}
    end,
}
