SMODS.Atlas({
    key = "plant",
    path = "j_cl_plant.png",
    px = 71,
    py = 95
})


SMODS.Joker{
    key = "plant",
    config = { extra = { chips = 0, mult = 0, target_name = "High Card", stage_target = 1 } }, --target_name does not keep state, only for tooltip
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 3,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'plant',
    soul_pos = nil,

    load = function(self, card, card_table, other_card)
        G.E_MANAGER:add_event(Event({
            func = function()
                local new_pos = { x = (card.ability.extra.stage_target - 1), y = 0 }
                card.children.center.sprite_pos = new_pos
                return true
            end
        }))
    end,

    calculate = function(self, card, context)
        if context.before
        and card.ability.extra.stage_target
        and context.scoring_name == G._cl_.HANDS_ORDERED[card.ability.extra.stage_target].hand
        and not context.blueprint then
            local reward = G._cl_.HANDS_ORDERED[card.ability.extra.stage_target]
            if reward then
                card.ability.extra.chips = 2 * reward.chips
                card.ability.extra.mult = 2 * reward.mult
                card.ability.extra.stage_target = card.ability.extra.stage_target + 1
                card.ability.extra.target_name = G._cl_.HANDS_ORDERED[card.ability.extra.stage_target].hand or "(max)"
            end

            play_sound('crumple1')
            local new_pos = { x = (card.ability.extra.stage_target - 1), y = 0 }
            card.children.center.sprite_pos = new_pos
            return {
                message = localize('a_watered'),
                colour = G.C.GREEN,
            }
        end

        if context.joker_main then
            if card.ability.extra.chips > 0 or card.ability.extra.mult > 0 then
                return {
                    chips = card.ability.extra.chips,
                    mult = card.ability.extra.mult,
                    colour = G.C.CHIPS,
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {
                card.ability.extra.chips,
                card.ability.extra.mult,
                G.localization.misc.poker_hands[card.ability.extra.target_name],
        }}
    end,
}
