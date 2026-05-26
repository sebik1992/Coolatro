SMODS.Atlas({
    key = "caleidoscope",
    path = "j_cl_caleidoscope.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "caleidoscope",
    config = { extra = { x_mult = 1, x_mult_mod = 0.1, poker_hand = "Flush" } },
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'caleidoscope',
    soul_pos = nil,

    calculate = function(self, card, context)
        local hand = card.ability.extra.poker_hand

        if context.before and context.scoring_name == hand then
            local current_suit = context.scoring_hand[1].base.suit

            local suits = {}
            for _, suit in ipairs(G._cl_.SUITS) do
                if suit ~= current_suit then
                    suits[#suits + 1] = suit
                end
            end

            local chosen_suit = pseudorandom_element(suits, pseudoseed('caleidoscope_suit'))

            for _, played_card in ipairs(context.scoring_hand) do
                SMODS.change_base(played_card, chosen_suit)
            end

            return {
                message = G.localization.misc.suits_plural[chosen_suit],
                colour = G.C.SUITS[chosen_suit],
            }
        end

        if context.joker_main then
            if context.scoring_name == hand and not context.blueprint then
                card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_mod
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.RED,
                })
            end
            return {
                colour = G.C.RED,
                x_mult = card.ability.extra.x_mult
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {
            card.ability.extra.x_mult,
            card.ability.extra.x_mult_mod,
            G.localization.misc.poker_hands[card.ability.extra.poker_hand],
        }}
    end,
}
