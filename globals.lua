-- GLOBALS

G._cl_ = {
    RANK_POOL = {"2","3","4","5","6","7","8","9","10","Jack","Queen","King","Ace"},
    SUITS = { "Spades", "Hearts", "Clubs", "Diamonds" },
    HANDS_ORDERED = {
            { hand = "High Card",       chips = 5,   mult = 1 },
            { hand = "Pair",            chips = 10,  mult = 2 },
            { hand = "Two Pair",        chips = 20,  mult = 2 },
            { hand = "Three of a Kind", chips = 30,  mult = 3 },
            { hand = "Straight",        chips = 30,  mult = 4 },
            { hand = "Flush",           chips = 35,  mult = 4 },
            { hand = "Full House",      chips = 40,  mult = 4 },
            { hand = "Four of a Kind",  chips = 60,  mult = 7 },
            { hand = "Straight Flush",  chips = 100, mult = 8 },
            { hand = "Five of a Kind",  chips = 120, mult = 12 },
            { hand = "Flush House",     chips = 140, mult = 14 },
            { hand = "Flush Five",      chips = 160, mult = 16 },
        },
}

G.C._cl_ = {
    RED = HEX("FF0000"),
    BLACK = HEX("000000"),
    BLUE = HEX("0000FF"),
    GREEN = HEX("00FF00"),
    WHITE = HEX("FFFFFF"),
    TRANSPARENT = HEX("00000000"),
}

-- Feature flags

SMODS.current_mod.optional_features = function()
    return {
        retrigger_joker = true,
    }
end

-- Hooks

local loc_colour_ref = loc_colour
function loc_colour(_c, _default)
    if not G.ARGS.LOC_COLOURS then
        loc_colour_ref()
    end
    G.ARGS.LOC_COLOURS._cl__red = G.C._cl_.RED
    G.ARGS.LOC_COLOURS._cl__black = G.C._cl_.BLACK
    G.ARGS.LOC_COLOURS._cl__blue = G.C._cl_.BLUE
    G.ARGS.LOC_COLOURS._cl__green = G.C._cl_.GREEN
    G.ARGS.LOC_COLOURS._cl__white = G.C._cl_.WHITE
    G.ARGS.LOC_COLOURS._cl__transparent = G.C._cl_.TRANSPARENT
    return loc_colour_ref(_c, _default)
end