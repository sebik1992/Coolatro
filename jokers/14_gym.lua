SMODS.Atlas({
    key = "gym",
    path = "j_cl_gym.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "gym",
    config = { },
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'gym',
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.before and then
            local min_id = 15
            for _, c in ipairs(context.scoring_hand) do
                local id = c:get_id()
                if id > 0 and id < min_id then min_id = id end
            end
            if min_id < 15 then
                local new_id = min_id == 14 and 2 or min_id + 1
                local rank_suffix
                if new_id < 10 then rank_suffix = tostring(new_id)
                elseif new_id == 10 then rank_suffix = 'T'
                elseif new_id == 11 then rank_suffix = 'J'
                elseif new_id == 12 then rank_suffix = 'Q'
                elseif new_id == 13 then rank_suffix = 'K'
                elseif new_id == 14 then rank_suffix = 'A'
                end
                for _, c in ipairs(context.scoring_hand) do
                    if c:get_id() == min_id then
                        local suit_prefix = string.sub(c.base.suit, 1, 1)..'_'
                        c:set_base(G.P_CARDS[suit_prefix..rank_suffix])
                        card_eval_status_text(c, 'jokers', nil, nil, nil, { message = localize('k_upgrade_ex'), colour = G.C.ORANGE })
                    end
                end
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { }
    end,
}
