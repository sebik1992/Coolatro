SMODS.Atlas({
    key = "rock_n_roll",
    path = "j_cl_rock_n_roll.png",
    px = 71,
    py = 95
})

SMODS.Sound{
    key = "guitar_riff",
    path = "cl_guitar_riff.ogg"
}

SMODS.Joker{
    key = "rock_n_roll",
    config = { extra = { repetitions = 3 } },
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'rock_n_roll',
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if context.other_card.ability.effect == 'Stone Card' then
                return {
                    message = localize('k_again_ex'),
                    sound = 'cl_guitar_riff',
                    repetitions = card.ability.extra.repetitions,
                    card = context.other_card
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS['m_stone']
        return { vars = { card.ability.extra.repetitions } }
    end,
}
