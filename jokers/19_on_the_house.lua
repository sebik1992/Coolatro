SMODS.Atlas({
    key = "on_the_house",
    path = "j_cl_on_the_house.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "on_the_house",
    config = { extra = { prob_top = 1, prob_bottom = 2, poker_hand = "Full House" } },
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'on_the_house',
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.scoring_name == card.ability.extra.poker_hand then
            if context.other_card:get_id() >= 2 and context.other_card:get_id() <= 10 then 
                if pseudorandom('steel_forge') < G.GAME.probabilities.normal * card.ability.extra.prob_top / card.ability.extra.prob_bottom then
                    context.other_card:set_ability(G.P_CENTERS['m_steel'], nil, true)
                    return {
                        extra = {focus = card, message = localize('k_upgrade_ex')},
                        card = card,
                        colour = G.C.CHIPS
                    }
                end
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS['m_steel']
        return { vars = {
            card.ability.extra.prob_top * (G.GAME and G.GAME.probabilities.normal or 1),
            card.ability.extra.prob_bottom,
            G.localization.misc.poker_hands[card.ability.extra.poker_hand],
        }}
    end,
}