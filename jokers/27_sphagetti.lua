SMODS.Atlas({
    key = "sphagetti",
    path = "j_cl_sphagetti.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "sphagetti",
    config = { extra = { rounds_left = 4 } },
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 5,
    blueprint_compat = false,
    eternal_compat = false,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'sphagetti',
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            G.E_MANAGER:add_event(Event({func = function()
                G.E_MANAGER:add_event(Event({func = function()
                    local enhanced = {}
                    for _, c in ipairs(G.deck.cards) do
                        if c.config.center.set == 'Enhanced' then
                            enhanced[#enhanced + 1] = c
                        end
                    end

                    if #enhanced > 0 then
                        local round_key = tostring(G.GAME.round_resets.ante or 1) .. '_' .. tostring(G.GAME.round_resets.round or 1)
                        for i = #enhanced, 2, -1 do
                            local j = math.floor(pseudorandom(pseudoseed('cl_sphagetti_' .. round_key .. '_' .. i)) * i) + 1
                            enhanced[i], enhanced[j] = enhanced[j], enhanced[i]
                        end

                        for _, c in ipairs(enhanced) do
                            c.area:remove_card(c)
                        end
                        for _, c in ipairs(enhanced) do
                            G.deck.cards[#G.deck.cards + 1] = c
                            c:set_card_area(G.deck)
                        end
                        G.deck:set_ranks()
                        G.deck:align_cards()

                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = localize('a_reshuffled'),
                            colour = G.C.GREEN
                        })
                    end

                    card.ability.extra.rounds_left = card.ability.extra.rounds_left - 1
                    if card.ability.extra.rounds_left <= 0 then
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = localize('k_eaten_ex'),
                            colour = G.C.GREEN
                        })
                        card:start_dissolve()
                    end
                    return true
                end}))
                return true
            end}))
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {
            card.ability.extra.rounds_left,
        }}
    end,
}
