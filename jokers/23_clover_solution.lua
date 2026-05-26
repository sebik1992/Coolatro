SMODS.Atlas({
    key = "clover_solution",
    path = "j_cl_clover_solution.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "clover_solution",
    config = { extra = { luck_mult = 1 } },
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 5,
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'clover_solution',
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local clubs_no = 0
            for _, c in ipairs(context.scoring_hand) do
                if c:is_suit('Clubs') then
                    clubs_no = clubs_no + 1
                end
            end
            if clubs_no >= 2 and clubs_no <= 4 then
                card.ability.extra.luck_mult = card.ability.extra.luck_mult * 2
                for k, v in pairs(G.GAME.probabilities) do
                    G.GAME.probabilities[k] = v * 2
                end
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex'), colour = G.C.GREEN})
            end
        end
        if context.setting_blind and card.ability.extra.luck_mult > 1 then
            for k, v in pairs(G.GAME.probabilities) do
                G.GAME.probabilities[k] = v / card.ability.extra.luck_mult
            end
            card.ability.extra.luck_mult = 1
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_reset'), colour = G.C.GREEN})
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        if from_debuff and card.ability.extra.luck_mult > 1 then
            for k, v in pairs(G.GAME.probabilities) do
                G.GAME.probabilities[k] = v * card.ability.extra.luck_mult
            end
        end
    end,

    remove_from_deck = function(self, card, from_debuff)
        if card.ability.extra.luck_mult > 1 then
            for k, v in pairs(G.GAME.probabilities) do
                G.GAME.probabilities[k] = v / card.ability.extra.luck_mult
            end
            if not from_debuff then
                card.ability.extra.luck_mult = 1
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.luck_mult
        } }
    end,
}
