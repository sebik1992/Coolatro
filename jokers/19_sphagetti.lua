SMODS.Atlas({
    key = "sphagetti",
    path = "j_cl_sphagetti.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "sphagetti",
    config = { extra = { rounds_left = 4 } },
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = false,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'sphagetti',
    soul_pos = nil,

    --calculate = function(self, card, context)
        
    --end,

    loc_vars = function(self, info_queue, card)
        return { vars = {
            card.ability.extra.rounds_left,
        }}
    end,
}
