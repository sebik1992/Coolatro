SMODS.Atlas({
    key = "retrograde",
    path = "j_cl_retrograde.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "retrograde",
    config = { },
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 7,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'retrograde',
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint then
            local consumeable = context.consumeable
            if not (consumeable and consumeable.ability.set == 'Planet') then return end
            local hand_type = consumeable.ability.consumeable and consumeable.ability.consumeable.hand_type
            if not hand_type then return end

            local hand_data = G.GAME.hands[hand_type]
            -- level_up_hand already ran, so current level is post-upgrade; prev = current - 1
            local prev_level = (tonumber(tostring(hand_data.level)) or 1) - 1

            local was_min = true
            for _, hd in pairs(G.GAME.hands) do
                if hd ~= hand_data then
                    local l = tonumber(tostring(hd.level)) or 1
                    if l < prev_level then was_min = false; break end
                end
            end

            if was_min then
                local has_room = #G.consumeables.cards < G.consumeables.config.card_limit
                if has_room then
                    local created = create_card('Spectral', G.consumeables, nil, nil, nil, nil, 'c_trance', 'retrograde')
                    created:add_to_deck()
                    G.consumeables:emplace(created)
                end
                return {
                    message = localize('k_plus_spectral'),
                    colour = G.C.BLUE,
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS['c_trance']
        return { }
    end,
}
