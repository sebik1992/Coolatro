SMODS.Atlas({
    key = "bar_code",
    path = "j_cl_bar_code.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "bar_code",
    config = { extra = { payout = 0, payout_increase = 3 } },
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'bar_code',
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local diamonds_no = 0
            for _, c in ipairs(context.scoring_hand) do
                if c.base.suit == 'Diamonds' or c.ability.effect == 'Wild Card' then
                    diamonds_no = diamonds_no + 1
                end
            end
            if diamonds_no >= 2 and diamonds_no <= 4 then
                card.ability.extra.payout = card.ability.extra.payout + card.ability.extra.payout_increase
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.GOLD,
                })
                ease_dollars(card.ability.extra.payout)
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = "$"..card.ability.extra.payout,
                    colour = G.C.GOLD,
                })
            end
        end
        if context.end_of_round and G.GAME.blind.boss and not context.blueprint and not (context.individual or context.repetition) then
            card.ability.extra.payout = 0
            card_eval_status_text(card, 'extra', nil, nil, nil, {
                message = localize('k_reset'),
                colour = G.C.RED,
            })
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.payout,
            card.ability.extra.payout_increase,
        } }
    end,
}
