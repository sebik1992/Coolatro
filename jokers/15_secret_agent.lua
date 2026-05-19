SMODS.Atlas({
    key = "secret_agent",
    path = "j_cl_secret_agent.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "secret_agent",
    config = { extra = { x_mult = 2 } },
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'secret_agent',
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.joker_main then
            for _, c in ipairs(G.hand.cards) do
                if c:is_face() then return end
            end
            return { colour = G.C.RED, x_mult = card.ability.extra.x_mult }
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {
            card.ability.extra.x_mult,
        }}
    end,
}
