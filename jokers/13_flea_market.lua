SMODS.Atlas({
    key = "flea_market",
    path = "j_cl_flea_market.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "flea_market",
    config = { extra = { tarrot_rank = "2", planet_rank = "3", prob_top = 1, prob_bottom = 3 } },
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'flea_market',
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.discard then
            local id = context.other_card.base.value
            local has_room = #G.consumeables.cards < G.consumeables.config.card_limit

            local function try_create(rank, card_type, seed, colour, message_key)
                if id == rank and has_room then
                    if pseudorandom(seed) < G.GAME.probabilities.normal * card.ability.extra.prob_top / card.ability.extra.prob_bottom then
                        local created = create_card(card_type, G.consumeables, nil, nil, nil, nil, nil, 'flea')
                        created:add_to_deck()
                        G.consumeables:emplace(created)
                        return {
                            extra = { focus = context.other_card, message = localize(message_key) },
                            card = card,
                            colour = colour,
                        }
                    end
                end
            end

            return try_create(card.ability.extra.tarrot_rank, 'Tarot', 'flea_tarot', G.C.PURPLE, 'k_plus_tarot')
                or try_create(card.ability.extra.planet_rank, 'Planet', 'flea_planet', G.C.BLUE, 'k_plus_planet')
        end

        if context.end_of_round and not context.blueprint and not (context.individual or context.repetition) then


            card.ability.extra.tarrot_rank = pseudorandom_element(G._cl_.RANK_POOL, pseudoseed('flea_tarot_rank'))
            repeat
                card.ability.extra.planet_rank = pseudorandom_element(G._cl_.RANK_POOL, pseudoseed('flea_planet_rank'))
            until card.ability.extra.planet_rank ~= card.ability.extra.tarrot_rank
            
            return {
                message = G.localization.misc.ranks[card.ability.extra.tarrot_rank].." & "..G.localization.misc.ranks[card.ability.extra.planet_rank],
                colour = G.C.CHIPS,
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {
            G.localization.misc.ranks[card.ability.extra.tarrot_rank],
            G.localization.misc.ranks[card.ability.extra.planet_rank],
            card.ability.extra.prob_top * (G.GAME and G.GAME.probabilities.normal or 1),
            card.ability.extra.prob_bottom,
        }}
    end,
}
