SMODS.Atlas({
    key = "supply_key",
    path = "j_cl_supply_key.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "supply_key",
    config = { extra = { prob_top = 1, prob_bottom = 100 } },
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'supply_key',
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.open_booster then
            G.E_MANAGER:add_event(Event({
                func = function()
                    if G.pack_cards and G.pack_cards.cards then
                        for i = #G.pack_cards.cards, 1, -1 do
                            local pack_card = G.pack_cards.cards[i]
                            if pseudorandom('supply_key'..i..G.GAME.round_resets.ante) <
                               card.ability.extra.prob_top * G.GAME.probabilities.normal / card.ability.extra.prob_bottom then
                                local ox, oy = pack_card.T.x, pack_card.T.y
                                G.pack_cards:remove_card(pack_card)
                                pack_card:start_dissolve()
                                local new_card = create_card('Joker', G.pack_cards, true, nil, true, true, nil, 'skl'..i)
                                new_card.T.x = ox
                                new_card.T.y = oy
                                new_card:start_materialize({G.C.WHITE, G.C.WHITE}, nil, 1.5*G.SETTINGS.GAMESPEED)
                                G.pack_cards:emplace(new_card)
                                card_eval_status_text(card, 'extra', nil, nil, nil, {
                                    message = localize('k_legendary'),
                                    colour = G.C.RARITY[4],
                                })
                            end
                        end
                    end
                    return true
                end
            }))
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {
            card.ability.extra.prob_top * (G.GAME and G.GAME.probabilities.normal or 1),
            card.ability.extra.prob_bottom,
        }}
    end,
}
