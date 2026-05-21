SMODS.Atlas({
    key = "vip_pass",
    path = "j_cl_vip_pass.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "vip_pass",
    config = { extra = { hands = 0, hand_req = 3 } },
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'vip_pass',
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local spades_no = 0
            for _, c in ipairs(context.scoring_hand) do
                if c.base.suit == 'Spades' then
                    spades_no = spades_no + 1
                end
            end
            if spades_no == 2 then
                card.ability.extra.hands = card.ability.extra.hands + 1
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = card.ability.extra.hands .. '/' .. card.ability.extra.hand_req,
                    colour = G.C.BLUE,
                })
                if card.ability.extra.hands >= card.ability.extra.hand_req then
                    card.ability.extra.hands = 0
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            add_tag(Tag('tag_voucher'))
                            return true
                        end
                    }))
                end
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'tag_voucher', set = 'Tag'}
        return { vars = {
            card.ability.extra.hands,
            card.ability.extra.hand_req,
        } }
    end,
}
