SMODS.Atlas({
    key = "jackpot",
    path = "j_cl_jackpot.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "jackpot",
    config = { extra = { prob_top = 1, prob_bottom = 7 } },
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 7,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'jackpot',
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if context.other_card.base.value == '7' then
                if pseudorandom(pseudoseed('jackpot')) < G.GAME.probabilities.normal * card.ability.extra.prob_top / card.ability.extra.prob_bottom then
                    local candidates = {}
                    for _, j in ipairs(G.jokers.cards) do
                        if not j.edition then
                            table.insert(candidates, j)
                        end
                    end
                    if #candidates > 0 then
                        local target = pseudorandom_element(candidates, pseudoseed('jackpot_target'))
                        local editions = { 'e_foil', 'e_holo', 'e_polychrome' }
                        local edition = pseudorandom_element(editions, pseudoseed('jackpot_edition'))
                        target:juice_up(0.3, 0.5)
                        target:set_edition(edition, true, true)
                        card_eval_status_text(target, 'extra', nil, nil, nil, {
                            message = localize('a_jackpot'),
                            colour = G.C.GOLD,
                        })
                    end
                end
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS['e_foil']
        info_queue[#info_queue + 1] = G.P_CENTERS['e_holo']
        info_queue[#info_queue + 1] = G.P_CENTERS['e_polychrome']
        return { vars = {
            card.ability.extra.prob_top * (G.GAME and G.GAME.probabilities.normal or 1),
            card.ability.extra.prob_bottom,
        }}
    end,
}
