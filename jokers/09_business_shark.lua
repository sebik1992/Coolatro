SMODS.Atlas({
    key = "business_shark",
    path = "j_cl_business_shark.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "business_shark",
    config = { extra = { x_mult = 3, cost_mod = 3 } },
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'business_shark',
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.starting_shop or context.reroll_shop then
            G.E_MANAGER:add_event(Event({
                func = function()
                    if context.starting_shop then -- Starting shop: increase all card types
                        for _, shop_table in ipairs({G.shop_jokers, G.shop, G.shop_vouchers, G.shop_booster}) do
                            if shop_table and shop_table.cards then
                                for _, c in ipairs(shop_table.cards) do
                                    c.cost = c.cost + card.ability.extra.cost_mod
                                end
                            end
                        end
                    elseif context.reroll_shop then -- Reroll: only increase jokers
                        if G.shop_jokers and G.shop_jokers.cards then
                            for _, c in ipairs(G.shop_jokers.cards) do
                                c.cost = c.cost + card.ability.extra.cost_mod
                            end
                        end
                    end
                    
                    save_run()
                    return true
                end
            }))
        end
        if context.joker_main and context.cardarea == G.jokers and context.scoring_name then
            return {
                colour = G.C.RED,
                x_mult = card.ability.extra.x_mult
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {
            card.ability.extra.x_mult,
            card.ability.extra.cost_mod,
        }}
    end,
}
