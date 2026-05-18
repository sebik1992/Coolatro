SMODS.Atlas({
    key = "knight",
    path = "j_cl_knight.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "knight",
    config = { extra = { boss_hands = 3 } },
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'knight',

    calculate = function(self, card, context)
        if context.setting_blind and context.blind and context.blind.boss then
            G.E_MANAGER:add_event(Event({func = function()
                ease_hands_played(card.ability.extra.boss_hands)
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = localize{type = 'variable', key = 'a_hands', vars = {card.ability.extra.boss_hands}},
                    colour = G.C.BLUE
                })
                return true
            end}))
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.boss_hands } }
    end,
}
