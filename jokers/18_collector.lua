SMODS.Atlas({
    key = "collector",
    path = "j_cl_collector.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "collector",
    config = { extra = { in_standard = false } },
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 1,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'collector',
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.open_booster and not context.blueprint then
            local booster = context.card
            local key = booster and booster.config and booster.config.center and (booster.config.center.key or "") or ""
            card.ability.extra.in_standard = key:find("standard") ~= nil
        end

        if context.playing_card_added and card.ability.extra.in_standard and not context.blueprint then
            card.ability.extra.in_standard = false
            for _, playing_card in ipairs(context.cards) do
                card.ability.extra_value = (card.ability.extra_value or 0) + playing_card:get_id()
            end
            card_eval_status_text(card, 'extra', nil, nil, nil, {
                message = localize('k_upgrade_ex'),
                colour = G.C.GOLD,
            })
        end
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS['p_standard_1']
        return { vars = {
            card.ability.extra_value or 0,
        }}
    end,
}
