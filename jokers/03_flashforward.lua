SMODS.Atlas({
    key = "flashforward",
    path = "j_cl_flashforward.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "flashforward",
    config = { },
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 3,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'flashforward',
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.skip_blind then
            G.E_MANAGER:add_event(Event({
                func = function()
                    add_tag(Tag('tag_double'))
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = "+1 "..localize('a_tag'),
                        colour = G.C.GOLD,
                        card = card
                    })
                    return true
                end
            }))
        end
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS['tag_double']
        return { }
    end,
}
