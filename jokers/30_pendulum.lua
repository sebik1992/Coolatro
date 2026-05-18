SMODS.Atlas({
    key = "pendulum",
    path = "j_cl_pendulum.png",
    px = 71,
    py = 95
})

local function is_joker_active(pendulum, joker)
    return (pendulum.ability.extra.swings_right and joker.ability.extra.cl_pendulum_right)
        or (not pendulum.ability.extra.swings_right and joker.ability.extra.cl_pendulum_left)
end

local function pendulum_debuff_all(pendulum, is_debuff)
    for _, j in ipairs(G.jokers.cards) do
        if j ~= pendulum and not is_joker_active(pendulum, j) then j.debuff = is_debuff end
    end
end

local function pendulum_sprite(pendulum)
    pendulum.children.center.sprite_pos =
        pendulum.ability.extra.swings_right and { x = 0, y = 0 } or { x = 1, y = 0 }
end


SMODS.Joker{
    key = "pendulum",
    config = { extra = { swings_right = true } },
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 9,
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'pendulum',

    calculate = function(self, pendulum, context)
        if context.setting_blind then
            local my_idx
            for i, j in ipairs(G.jokers.cards) do
                if j == pendulum then my_idx = i; break end
            end
            if not my_idx then return end

            for i, j in ipairs(G.jokers.cards) do
                j.ability.extra.cl_pendulum_left  = nil
                j.ability.extra.cl_pendulum_right = nil
                if i == my_idx - 1 or i == my_idx - 2 then
                    j.ability.extra.cl_pendulum_left = true
                elseif i == my_idx + 1 or i == my_idx + 2 then
                    j.ability.extra.cl_pendulum_right = true
                end
            end

            pendulum_debuff_all(pendulum, true)
        end

        if context.retrigger_joker_check then
            if is_joker_active(pendulum, context.other_card) then
                return { message = localize('k_again_ex'), colour = G.C.BLUE, repetitions = 2 }
            end
        end

        if context.after then
            pendulum_debuff_all(pendulum, false)
            pendulum.ability.extra.swings_right = not pendulum.ability.extra.swings_right
            pendulum_debuff_all(pendulum, true)

            G.E_MANAGER:add_event(Event({ func = function() pendulum_sprite(pendulum); return true end }))

            card_eval_status_text(pendulum, 'extra', nil, nil, nil, {
                message = pendulum.ability.extra.swings_right and ">>" or "<<",
                colour  = G.C.BLUE,
            })
        end

        if context.end_of_round and not context.individual and not context.repetition then
            pendulum_debuff_all(pendulum, false)
            for _, j in ipairs(G.jokers.cards) do
                if j ~= pendulum then
                    j.ability.extra.cl_pendulum_left  = nil
                    j.ability.extra.cl_pendulum_right = nil
                end
            end
        end
    end,

    loc_vars = function(self, info_queue, pendulum)
        return { vars = {
            pendulum.ability.extra.swings_right and localize('a_right') or localize('a_left'),
        }}
    end,
}
