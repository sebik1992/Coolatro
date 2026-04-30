SMODS.Atlas({
    key = "patchwork",
    path = "j_cl_patchwork.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "patchwork",
    config = { extra = { chips = 30 } },
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 3,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'patchwork',
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers and context.scoring_name then
            local seen = {}
            local unique_count = 0
            local sources = { context.scoring_hand, G.hand and G.hand.cards }

            for _, source in ipairs(sources) do
                for _, c in ipairs(source or {}) do
                    local key = c.config.center.key
                    if c.config.center.set == "Enhanced" and not seen[key] then
                        seen[key] = true
                        unique_count = unique_count + 1
                    end
                end
            end
            if unique_count > 0 then
                return {
                    chips = unique_count * card.ability.extra.chips,
                    colour = G.C.CHIPS,
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {
            card.ability.extra.chips,
        }}
    end,
}
