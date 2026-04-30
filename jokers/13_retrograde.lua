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
        if context.before and not context.blueprint then
            local hand_name = context.scoring_name
            local hand_data = G.GAME.hands[hand_name]
            local has_room = #G.consumeables.cards < G.consumeables.config.card_limit

            if hand_data and hand_data.level > 1 then
                level_up_hand(card, hand_name, false, -1)
                update_hand_text(
                    { sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
                    {
                        handname = localize(hand_name, 'poker_hands'),
                        chips = G.GAME.hands[hand_name].chips,
                        mult = G.GAME.hands[hand_name].mult,
                        level = G.GAME.hands[hand_name].level,
                    }
                )
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
        return { vars = {
            G.P_CENTERS['c_trance'].name, --todo PL translate
        }}
    end,
}
