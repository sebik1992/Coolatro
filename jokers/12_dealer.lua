SMODS.Atlas({
    key = "dealer",
    path = "j_cl_dealer.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "dealer",
    config = { extra = {} },
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'dealer',

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            G.E_MANAGER:add_event(Event({func = function()
                local enhanced = {}
                for _, c in ipairs(G.deck.cards) do
                    if c.config.center.set == 'Enhanced' then
                        enhanced[#enhanced + 1] = c
                    end
                end

                if #enhanced == 0 then return true end

                -- Fisher-Yates shuffle; seed varies per ante/round so order differs each blind
                local round_key = tostring(G.GAME.round_resets.ante or 1)
                    .. '_' .. tostring(G.GAME.round_resets.round or 1)
                for i = #enhanced, 2, -1 do
                    local j = math.floor(pseudorandom(pseudoseed('cl_dealer_' .. round_key .. '_' .. i)) * i) + 1
                    enhanced[i], enhanced[j] = enhanced[j], enhanced[i]
                end

                -- Pull enhanced cards out of their current deck positions
                for _, c in ipairs(enhanced) do
                    c.area:remove_card(c)
                end
                -- Re-insert in reverse so enhanced[1] ends up topmost
                for i = #enhanced, 1, -1 do
                    G.deck:emplace(enhanced[i])
                end

                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = localize('k_deal'),
                    colour = G.C.GREEN
                })
                return true
            end}))
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
}
