SMODS.Atlas({
    key = "mult",
    path = "j_cl_mult.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "mult",
    config = { extra = { mult_mod = 2 } },
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'mult',

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play
        and context.other_card.ability.effect == "Mult Card" then
            context.other_card.ability.mult = context.other_card.ability.mult + card.ability.extra.mult_mod
            return {
                mult = card.ability.extra.mult_mod,
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS['m_mult']
        return { vars = { card.ability.extra.mult_mod } }
    end,
}
