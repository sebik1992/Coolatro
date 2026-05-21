SMODS.Atlas({
    key = "bench",
    path = "j_cl_bench.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "bench",
    config = { extra = { x_mult = 2 } },
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 5,
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'bench',

    calculate = function(self, card, context)
        if context.joker_main then
            local types = {}
            if G.consumeables and G.consumeables.cards then
                for _, c in ipairs(G.consumeables.cards) do
                    if c.ability and c.ability.set then
                        types[c.ability.set] = true
                    end
                end
            end
            local count = 0
            for _ in pairs(types) do count = count + 1 end
            if count > 0 then
                return {
                    colour = G.C.RED,
                    x_mult = card.ability.extra.x_mult ^ count
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.x_mult
         } }
    end,
}
