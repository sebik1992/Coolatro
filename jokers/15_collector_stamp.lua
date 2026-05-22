SMODS.Atlas({
    key = "collector_stamp",
    path = "j_cl_collector_stamp.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "collector_stamp",
    config = { extra = { in_standard = false } },
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 1,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'collector_stamp',
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.open_booster and not context.blueprint then
            local booster = context.card
            local key = booster and booster.config and booster.config.center and (booster.config.center.key or "") or ""
            card.ability.extra.in_standard = key:find("standard") ~= nil
        end

        if context.playing_card_added and card.ability.extra.in_standard and not context.blueprint then
            for _, playing_card in ipairs(context.cards) do
                card.ability.extra_value = (card.ability.extra_value or 0) + math.min(playing_card:get_chip_bonus(), 20)
            end
            card:set_cost()
            card_eval_status_text(card, 'extra', nil, nil, nil, {
                message = localize('k_val_up'),
                colour = G.C.GOLD,
            })
            if not (G.GAME.pack_choices and G.GAME.pack_choices > 1) then
                card.ability.extra.in_standard = false
            end
        end

        if context.skipping_booster then
            card.ability.extra.in_standard = false
        end
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.p_standard_normal_1
        info_queue[#info_queue + 1] = G.P_CENTERS.p_standard_mega_1
        return { vars = {
            card.ability.extra_value or 0,
        }}
    end,
}
