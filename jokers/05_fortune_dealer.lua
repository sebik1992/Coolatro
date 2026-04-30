SMODS.Atlas({
    key = "fortune_dealer",
    path = "j_cl_fortune_dealer.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "fortune_dealer",
    config = { },
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'fortune_dealer',
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.starting_shop or context.reroll_shop then
            G.E_MANAGER:add_event(Event({
                func = function()
                    if G.shop_jokers then
                        for _, c in ipairs(G.shop_jokers.cards) do
                            c:remove()
                        end
                        G.shop_jokers.cards = {}
                        for i = 1, G.shop_jokers.config.card_limit do
                            local c = create_card('Tarot', G.shop_jokers, nil, nil, nil, nil, nil, 'shop')
                            c:add_to_deck()
                            G.shop_jokers:emplace(c)
                            create_shop_card_ui(c)
                        end
                    end
                    save_run() -- on reload keep rerolled cards
                    return true
                end
            }))
            return {
                message = localize('k_active_ex'),
                colour = G.C.PURPLE,
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { }
    end,
}
