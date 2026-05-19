SMODS.Atlas({
    key = "dealer",
    path = "j_cl_dealer.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "dealer",
    config = { extra = { active_rank = "Ace" } },
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 7,
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'dealer',

    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint and not (context.individual or context.repetition) then
            local seen_ranks = {}
            for _, r in ipairs(G._cl_.RANK_POOL) do
                for _, c in ipairs(G.playing_cards) do
                    if c.base.value == r then
                        seen_ranks[#seen_ranks + 1] = r
                        break
                    end
                end
            end
            if #seen_ranks > 0 then
                card.ability.extra.active_rank = pseudorandom_element(seen_ranks, pseudoseed('dealer_rank_pick'))
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = G.localization.misc.ranks[card.ability.extra.active_rank],
                    colour = G.C.GREEN
                })
            end
        end

        if context.setting_blind and not context.blueprint then
            local rank = card.ability.extra.active_rank

            -- Outer event only exists to push the inner event past the deck
            -- shuffle that new_round() queues right after setting_blind fires.
            G.E_MANAGER:add_event(Event({func = function()
                G.E_MANAGER:add_event(Event({func = function()
                    local targets = {}
                    for _, c in ipairs(G.deck.cards) do
                        if c.base.value == rank then
                            targets[#targets + 1] = c
                        end
                    end

                    if #targets == 0 then return true end

                    for _, c in ipairs(targets) do
                        c.area:remove_card(c)
                    end
                    -- emplace() inserts at index 1 for decks; remove_card draws
                    -- from index #cards. Append directly so these are dealt first.
                    for _, c in ipairs(targets) do
                        G.deck.cards[#G.deck.cards + 1] = c
                        c:set_card_area(G.deck)
                    end
                    G.deck:set_ranks()
                    G.deck:align_cards()

                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = localize('a_reshuffled'),
                        colour = G.C.GREEN
                    })
                    return true
                end}))
                return true
            end}))
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.active_rank and G.localization.misc.ranks[card.ability.extra.active_rank]
         } }
    end,
}
