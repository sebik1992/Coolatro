SMODS.Atlas({
    key = "stamped_delivery",
    path = "j_cl_stamped_delivery.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "stamped_delivery",
    config = { },
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'stamped_delivery',
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.playing_card_added and not context.blueprint then
            local seals = { 'Gold', 'Red', 'Blue', 'Purple' }
            for i, playing_card in ipairs(context.cards) do
                local id = playing_card:get_id()
                if id >= 2 and id <= 10 then
                    local chosen_seal = pseudorandom_element(seals, pseudoseed('stamp_factory_seal_'..i))
                    playing_card:set_seal(chosen_seal, true)
                    card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('k_upgrade_ex'), colour = G.C.GREEN })
                end
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { }
    end,
}