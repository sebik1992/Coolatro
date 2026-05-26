SMODS.Atlas({
    key = "heterochromia",
    path = "j_cl_heterochromia.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "heterochromia",
    config = { extra = { mult = 0, mult_mod = 1 } },
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'heterochromia',
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            if not context.blueprint then
                local black_suits_count = 0
                local red_suits_count = 0

                local wild_count = 0

                for _, c in ipairs(context.full_hand) do
                    if c.ability.effect ~= 'Stone Card' then
                        if c.ability.name == 'Wild Card' then
                            wild_count = wild_count + 1
                        elseif c.base.suit == "Spades" or c.base.suit == "Clubs" then
                            black_suits_count = black_suits_count + 1
                        elseif c.base.suit == "Hearts" or c.base.suit == "Diamonds" then
                            red_suits_count = red_suits_count + 1
                        end
                    end
                end

                local diff = math.abs(black_suits_count - red_suits_count)
                if wild_count >= diff and (wild_count - diff) % 2 == 0 then
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = localize('k_upgrade_ex'),
                        colour = G.C.RED,
                    })
                end
            end

            if card.ability.extra.mult > 0 then
                return {
                    mult = card.ability.extra.mult,
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {
            card.ability.extra.mult,
            card.ability.extra.mult_mod,
        }}
    end,
}
