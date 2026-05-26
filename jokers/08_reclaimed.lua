SMODS.Atlas({
    key = "reclaimed",
    path = "j_cl_reclaimed.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "reclaimed",
    config = { extra = { discards = 0, discard_mod = 1 } },
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'reclaimed',

    calculate = function(self, card, context)
        if context.reroll_shop and not context.blueprint then
            card.ability.extra.discards = card.ability.extra.discards + card.ability.extra.discard_mod
            card_eval_status_text(card, 'extra', nil, nil, nil, {
                message = localize('k_upgrade_ex'),
                colour = G.C.RED
            })
        end

        if context.setting_blind then
            if card.ability.extra.discards> 0 then
                ease_discard(card.ability.extra.discards)
                if not context.blueprint then
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = localize('k_reset'),
                        colour = G.C.RED
                    })
                    card.ability.extra.discards = 0
                end
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.discards,
            card.ability.extra.discard_mod,
        } }
    end,
}
