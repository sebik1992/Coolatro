SMODS.Atlas({
    key = "pinata",
    path = "j_cl_pinata.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "pinata",
    config = { extra = { cards = 0, cards_mod = 2 } },
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'pinata',
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint and not (context.individual or context.repetition) then
            card.ability.extra.cards = card.ability.extra.cards + card.ability.extra.cards_mod
            return {
                colour = G.C.GOLD,
                message = "+"..card.ability.extra.cards_mod.." "..localize('a_cards'),
            }
        end

        if context.selling_self then
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {
                message = localize('a_pop'),
                colour = G.C.GOLD,
            })
            play_sound('tarot1')

            if card.ability.extra.cards <= 0 then return end
            local editions = { "e_foil", "e_holo", "e_polychrome" }
            local candidates = {}
            for _, c in ipairs(G.playing_cards) do
                if not c.edition then
                    table.insert(candidates, c)
                end
            end
            for i = 1, math.min(card.ability.extra.cards, #candidates) do
                local targetIndex = pseudorandom(pseudoseed('pinata_pop'), 1, #candidates)
                local target = candidates[targetIndex]
                table.remove(candidates, targetIndex)

                local edition = pseudorandom_element(editions, pseudoseed('pinata_pop'))
                target:set_edition(edition, true, false)
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS['e_foil']
        info_queue[#info_queue + 1] = G.P_CENTERS['e_holo']
        info_queue[#info_queue + 1] = G.P_CENTERS['e_polychrome']
        return { vars = {
            card.ability.extra.cards,
            card.ability.extra.cards_mod,
        }}
    end,
}