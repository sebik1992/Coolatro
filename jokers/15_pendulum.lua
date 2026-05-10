SMODS.Atlas({
    key = "pendulum",
    path = "j_cl_pendulum.png",
    px = 71,
    py = 95
})

local function pendulum_clear_debuffs(card)
    for _, j in ipairs(card._pendulum_debuff or {}) do
        j.debuff = false
    end
end

local function pendulum_apply_debuffs(card)
    for _, j in ipairs(card._pendulum_debuff or {}) do
        j.debuff = true
    end
end

local function pendulum_build_sides(card)
    card._pendulum_retrigger = {}
    card._pendulum_debuff    = {}

    local extra = card.ability.extra
    local retrigger_indices = extra.swings_right
        and { extra.right1, extra.right2 }
        or  { extra.left1,  extra.left2  }

    local retrigger_set = {}
    for _, idx in ipairs(retrigger_indices) do
        local j = idx and G.jokers.cards[idx]
        if j and j ~= card then
            card._pendulum_retrigger[#card._pendulum_retrigger + 1] = j
            retrigger_set[j] = true
        end
    end

    for _, j in ipairs(G.jokers.cards) do
        if j ~= card and not retrigger_set[j] then
            card._pendulum_debuff[#card._pendulum_debuff + 1] = j
        end
    end
end

local function pendulum_sprite(card)
    card.children.center.sprite_pos =
        card.ability.extra.swings_right and { x = 0, y = 0 } or { x = 1, y = 0 }
end


SMODS.Joker{
    key = "pendulum",
    config = { extra = { swings_right = true, left1 = nil, left2 = nil, right1 = nil, right2 = nil } },
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 9,
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'pendulum',

    load = function(self, card, card_table, other_card)
        G.E_MANAGER:add_event(Event({
            func = function()
                pendulum_clear_debuffs(card)
                pendulum_build_sides(card)
                if G.GAME and G.GAME.blind and G.GAME.blind.active then
                    pendulum_apply_debuffs(card)
                end
                pendulum_sprite(card)
                return true
            end
        }))
    end,

    calculate = function(self, card, context)
        local extra = card.ability.extra

        if context.setting_blind then
            local my_idx
            for i, j in ipairs(G.jokers.cards) do
                if j == card then my_idx = i; break end
            end
            if not my_idx then return end

            local n = #G.jokers.cards
            local function clamp(i) return (i >= 1 and i <= n) and i or nil end
            extra.left1  = clamp(my_idx - 1)
            extra.left2  = clamp(my_idx - 2)
            extra.right1 = clamp(my_idx + 1)
            extra.right2 = clamp(my_idx + 2)

            pendulum_clear_debuffs(card)
            pendulum_build_sides(card)
            pendulum_apply_debuffs(card)
        end

        if context.retrigger_joker_check then
            for _, j in ipairs(card._pendulum_retrigger or {}) do
                if j == context.other_card then
                    return { message = localize('k_again_ex'), colour = G.C.BLUE, repetitions = 2 }
                end
            end
        end

        if context.after then
            pendulum_clear_debuffs(card)
            extra.swings_right = not extra.swings_right
            pendulum_build_sides(card)
            pendulum_apply_debuffs(card)

            G.E_MANAGER:add_event(Event({ func = function() pendulum_sprite(card); return true end }))

            card_eval_status_text(card, 'extra', nil, nil, nil, {
                message = extra.swings_right and ">>" or "<<",
                colour  = G.C.BLUE,
            })
        end

        if context.end_of_round and not context.individual and not context.repetition then
            pendulum_clear_debuffs(card)
            card._pendulum_debuff    = {}
            card._pendulum_retrigger = {}
        end
    end,

    loc_vars = function(self, info_queue, card)
        local swings_right = card.ability.extra.swings_right
        return { vars = {
            swings_right and localize('a_right') or localize('a_left'),
            swings_right and localize('a_left')  or localize('a_right'),
        }}
    end,
}
