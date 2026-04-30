SMODS.Atlas({
    key = "pendulum",
    path = "j_cl_pendulum.png",
    px = 71,
    py = 95
})

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
                for _, j in ipairs(card._pendulum_debuff or {}) do
                    j.debuff = false
                end

                card._pendulum_retrigger = {}
                card._pendulum_debuff    = {}

                local extra = card.ability.extra

                local retrigger_indices = extra.swings_right
                    and { extra.right1, extra.right2 }
                    or  { extra.left1,  extra.left2  }

                local debuff_indices = extra.swings_right
                    and { extra.left1,  extra.left2  }
                    or  { extra.right1, extra.right2 }

                local function safe_resolve(idx)
                    if not idx then return nil end
                    local j = G.jokers.cards[idx]
                    if not j or j == card then return nil end
                    return j
                end

                for _, idx in ipairs(retrigger_indices) do
                    local j = safe_resolve(idx)
                    if j then card._pendulum_retrigger[#card._pendulum_retrigger + 1] = j end
                end
                for _, idx in ipairs(debuff_indices) do
                    local j = safe_resolve(idx)
                    if j then card._pendulum_debuff[#card._pendulum_debuff + 1] = j end
                end

                if G.GAME and G.GAME.blind and G.GAME.blind.active then
                    for _, j in ipairs(card._pendulum_debuff) do
                        j.debuff = true
                        print("[Pendulum] load: debuffing " .. tostring(j.ability and j.ability.name))
                    end
                end

                local new_pos = extra.swings_right and { x = 0, y = 0 } or { x = 1, y = 0 }
                card.children.center.sprite_pos = new_pos

                return true
            end
        }))
    end,

    calculate = function(self, card, context)
        local extra = card.ability.extra

        local function build_sides()
            card._pendulum_retrigger = {}
            card._pendulum_debuff    = {}

            local retrigger_indices = extra.swings_right
                and { extra.right1, extra.right2 }
                or  { extra.left1,  extra.left2  }

            local debuff_indices = extra.swings_right
                and { extra.left1,  extra.left2  }
                or  { extra.right1, extra.right2 }

            for _, idx in ipairs(retrigger_indices) do
                local j = idx and G.jokers.cards[idx]
                if j then card._pendulum_retrigger[#card._pendulum_retrigger + 1] = j end
            end
            for _, idx in ipairs(debuff_indices) do
                local j = idx and G.jokers.cards[idx]
                if j then card._pendulum_debuff[#card._pendulum_debuff + 1] = j end
            end
        end

        if context.setting_blind then
            local my_idx = nil
            for i, j in ipairs(G.jokers.cards) do
                if j == card then my_idx = i; break end
            end
            if not my_idx then return end

            local function valid_idx(i)
                return (i >= 1 and i <= #G.jokers.cards) and i or nil
            end
            extra.left1  = valid_idx(my_idx - 1)
            extra.left2  = valid_idx(my_idx - 2)
            extra.right1 = valid_idx(my_idx + 1)
            extra.right2 = valid_idx(my_idx + 2)

            for _, j in ipairs(card._pendulum_debuff or {}) do
                j.debuff = false
            end

            build_sides()

            for _, j in ipairs(card._pendulum_debuff) do
                j.debuff = true
            end
        end

        if context.retrigger_joker_check then
            for _, j in ipairs(card._pendulum_retrigger or {}) do
                if j == context.other_card then
                    return {
                        message     = localize('k_again_ex'),
                        colour      = G.C.BLUE,
                        repetitions = 1,
                    }
                end
            end
        end

        if context.after then
            for _, j in ipairs(card._pendulum_debuff or {}) do
                j.debuff = false
            end

            extra.swings_right = not extra.swings_right
            build_sides()

            for _, j in ipairs(card._pendulum_debuff) do
                j.debuff = true
            end

            local new_pos = extra.swings_right and { x = 0, y = 0 } or { x = 1, y = 0 }
            G.E_MANAGER:add_event(Event({
                func = function()
                    card.children.center.sprite_pos = new_pos
                    return true
                end
            }))

            card_eval_status_text(card, 'extra', nil, nil, nil, {
                message = extra.swings_right and ">>" or "<<",
                colour  = G.C.BLUE,
            })
        end

        if context.end_of_round and not context.individual and not context.repetition then
            for _, j in ipairs(card._pendulum_debuff or {}) do
                j.debuff = false
            end
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
