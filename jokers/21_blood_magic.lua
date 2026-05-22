SMODS.Atlas({
    key = "blood_magic",
    path = "j_cl_blood_magic.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "blood_magic",
    config = { extra = { chips = 0 } },
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'blood_magic',
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local hearts = {}
            for _, c in ipairs(context.scoring_hand) do
                if c.base.suit == 'Hearts' or c.ability.effect == 'Wild Card' then
                    table.insert(hearts, c)
                end
            end
            if #hearts >= 2 and #hearts <= 4 then
                local idx = pseudorandom(pseudoseed('blood_magic'), 1, 2)
                local sacrifice = hearts[idx]
                local gained = sacrifice:get_chip_bonus()
                card.ability.extra.chips = card.ability.extra.chips + gained
                card_eval_status_text(sacrifice, 'extra', nil, nil, nil, {
                    message = localize('a_sacrificed'),
                    colour = G.C.RED,
                })
                sacrifice.destroyed = true
                G.E_MANAGER:add_event(Event({func = function()
                    sacrifice:start_dissolve()
                    return true
                end}))
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = localize{type = 'variable', key = 'a_chips', vars = {gained}},
                    colour = G.C.CHIPS,
                })
            end
        end

        if context.joker_main and card.ability.extra.chips > 0 then
            return { chips = card.ability.extra.chips }
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
}
