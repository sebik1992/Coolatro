SMODS.Atlas({
    key = "ghost",
    path = "j_cl_ghost.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "ghost",
    config = { extra = { shop_skipped = true } },
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'ghost',

    calculate = function(self, card, context)
        if context.buying_card then
            card.ability.extra.shop_skipped = false
        end
        if context.ending_shop then
            if card.ability.extra.shop_skipped then
                add_tag(Tag('tag_ethereal'))
            end
            card.ability.extra.shop_skipped = true
        end
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'tag_ethereal', set = 'Tag'}
        info_queue[#info_queue+1] = G.P_CENTERS.p_spectral_normal_1
        return { }
    end,
}
