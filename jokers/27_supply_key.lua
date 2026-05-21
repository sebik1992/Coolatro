SMODS.Atlas({
    key = "supply_key",
    path = "j_cl_supply_key.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "supply_key",
    config = { extra = { prob_top = 1, prob_bottom = 100 } },
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'supply_key',
    soul_pos = nil,

    calculate = function(self, card, context)

    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {
            card.ability.extra.prob_top * (G.GAME and G.GAME.probabilities.normal or 1),
            card.ability.extra.prob_bottom,
        }}
    end,
}
