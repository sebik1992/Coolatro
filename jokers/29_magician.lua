SMODS.Atlas({
    key = "magician",
    path = "j_cl_magician.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "magician",
    config = { },
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'magician',
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.end_of_round and not (context.individual or context.repetition) then
            local idx = nil
            for i, j in ipairs(G.jokers.cards) do
                if j == card then
                    idx = i
                    break
                end
            end
            local target = idx and G.jokers.cards[idx + 1]
            if not target then return end
            if target.config.center.rarity == 4 then return end

            local pool = {}
            for _, j in ipairs(G.P_CENTER_POOLS['Joker']) do
                if j.rarity == target.config.center.rarity and j.key ~= target.config.center.key then
                    pool[#pool + 1] = j
                end
            end
            if #pool == 0 then return end

            local new_center = pseudorandom_element(pool, pseudoseed('magic_trick'))
            target:flip()
            target:juice_up(0.5, 2)
            target:set_ability(new_center, nil, true)
            target:flip()

            return {
                message = localize('a_abracadabra'),
                colour = G.C.PURPLE,
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { }
    end,
}
