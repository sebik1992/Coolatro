return {
    descriptions = {
        Joker = {
            j_cl_patchwork = {
                name = "Zszywany Joker",
                text = {
                    "{C:chips}+#1#{} Żet. za każde unikalne {C:attention}Ulepszenie{}",
                    "na zagrywanych kartach lub trzymanych na ręce",
                },
            },
            j_cl_heterochromia = {
                name = "Heterochromia",
                text = {
                    "{C:mult}+#2#{} Mnoż. jeśli zagrywana jest równa liczba",
                    "kart {C:spades}czarnych{} i {C:hearts}czerwonych{}",
                    "{C:inactive}(Obecnie {C:mult}+#1#{C:inactive} Mnoż.){}"
                },
            },
            j_cl_ghost = {
                name = "Joker Duch",
                text = {
                    "Utwórz {C:spectral}Znacznik eteryczny{}",
                    "jeśli pominiesz {C:attention}sklep{}",
                    "bez zakupów"
                },
            },
            j_cl_futuristic = {
                name = "Futurystyczny Joker",
                text = {
                    "Utwórz {C:attention}Podwójny znacznik{}",
                    "po pominięciu {C:attention}Przeszkadzajki{}"
                },
            },
            j_cl_fortune_dealer = {
                name = "Wróżba na zamówienie",
                text = {
                    "Sklep zawieraja",
                    "wyłącznie karty {C:tarot}tarota{}"
                },
            },
            j_cl_stamped_delivery = {
                name = "Wysyłka z Pieczątką",
                text = {
                    "{C:attention}4{}, {C:attention}5{}, {C:attention}6{} i {C:attention}7{} otrzymują losową",
                    "{C:attention}pieczęć{} w momencie dodania do talii"
                },
            },
            j_cl_flea_market = {
                name = "Pchli Targ",
                text = {
                    "Odrzucone {C:attention}#1#{} mają szansę {C:green}#3# na #4#{}",
                    "by stworzyć kartę {C:tarot}Tarota{}",
                    "Odrzucone {C:attention}#2#{} mają szansę {C:green}#3# na #4#{}",
                    "by stworzyć kartę {C:planet}Planety{}",
                    "Ranga zmienia się co rundę",
                    "{C:inactive}(wymaga miejsca){}"
                },
            },
            j_cl_pinata = {
                name = "Piniata",
                text = {
                    "Sprzedaj tę kartę aby dodać",
                    "wersję {C:dark_edition}w folii{}, {C:dark_edition}holograficzą{}",
                    "albo {C:dark_edition}polichromowaną{} do kart w twojej talii",
                    "{C:attention}+#2#{} karty na rundę",
                    "{C:inactive}(Obecnie {C:attention}#1#{C:inactive} kart){}"
                },
            },
            j_cl_business_shark = {
                name = "Rekin Biznesu",
                text = {
                    "{X:mult,C:white} X#1# {} Mnoż.",
                    "Przedmioty w sklepie kosztują {C:money}$#2#{} więcej",
                },
            },
            j_cl_plant = {
                name = "Roślinka",
                text = {
                    "Daje podwójne Żet. i Mnoż. podstawowej wersji ręki pokerowej",
                    "Zagraj układ {C:attention}#3#{} aby podrosła",
                    "{C:inactive}(Obecnie {C:chips}+#1#{C:inactive} Żet. i {C:mult}+#2#{C:inactive} Mnoż.){}"
                },
            },
            j_cl_mult = {
                name = "Mnoż-Joker",
                text = {
                    "Każda zagrana {C:attention}karta Mnoż.{}",
                    "zyskuje na stałe",
                    "{C:mult}+#1#{} Mnoż. przy zagraniu"
                }
            },
            j_cl_knight = {
                name = "Rycerz",
                text = {
                    "Po wybraniu",
                    "{C:attention}Przeszkadzajki Bossa{}",
                    "otrzymaj {C:blue}+#1#{} ręce"
                }
            },
            j_cl_reclaimed = {
                name = "Joker z recyklingu",
                text = {
                    "{C:red}+#2#{} zrzutka w następnej rundzie za",
                    "każde przelosowanie sklepu",
                    "{C:inactive}(Obecnie {C:red}+#1#{C:inactive} zrzutek)"
                }
            },
            j_cl_secret_agent = {
                name = "Tajniak",
                text = {
                    "{X:mult,C:white} X#1# {} Mnoż. jeśli",
                    "nie ma kart z {C:attention}figurą{}",
                    "trzymanych na ręce"
                }
            },
            j_cl_gym = {
                name = "Siłka",
                text = {
                    "Podnieś najniższą",
                    "rangę punktujących",
                    "kart o {C:attention}1{}"
                }
            },
            j_cl_caleidoscope = {
                name = "Kalejdoskop",
                text = {
                    "Gdy zagrany układ to {C:attention}#3#{}",
                    "ten joker zyskuje {X:mult,C:white} X#2# {} Mnoż.",
                    "i zmienia kolor kart zagrywanej ręki",
                    "{C:inactive}(Obecnie {X:mult,C:white} X#1# {C:inactive} Mnoż.)"
                },
            },
            j_cl_on_the_house = {
                name = "Lej do fula",
                text = {
                    "Przy zagrywaniu układu {C:attention}#3#{}",
                    "zagrane {C:attention}karty numerowane{}",
                    "mają szansę {C:green}#1# na #2#{}",
                    "by stać się {C:attention}Stalowymi Kartami{}"
                },
            },
            j_cl_retrograde = {
                name = "Retrogradacja",
                text = {
                    "Zagrywane układy pokerowe powyżej poziomu 1",
                    "{C:red}zmniejszają{} poziom układu oraz",
                    "tworzą kartę ducha {C:spectral}#1#{}",
                    "{C:inactive}(wymaga miejsca){}"
                }
            },
            j_cl_blood_magic = {
                name = "Magia Krwi",
                text = {
                    "Jeśli zagrywana ręka zawiera",
                    "dokładnie 2 karty {C:hearts}Kier{},",
                    "poświęć losową z nich",
                    "i dodaj wartość do {C:chips}Żet.{}",
                    "{C:inactive}(Obecnie {C:chips}+#1#{C:inactive} Żet.){}"
                }
            },
            j_cl_dealer = {
                name = "Diler",
                text = {
                    "Po wybraniu {C:attention}Przeszkadzajki{}",
                    "umieść karty z rangą {C:attention}#1#{}",
                    "na wierzchu talii",
                    "{C:inactive}(Ranga zmienia się co rundę){}"
                }
            },
            j_cl_magician = {
                name = "Magik",
                text = {
                    "Na koniec rundy rundy zamienia",
                    "nielegendarnego {C:attention}Jokera{} na prawo",
                    "w innego o tym samym poziomie rzadkości"
                },
            },
            j_cl_pendulum = {
                name = "Pendulum",
                text = {
                    "Podczas przeszkadzajki:",
                    "Aktywuj potrójnie 2 Jokery na {C:attention}#1#{}",
                    "{C:red}Osłabia{} wszystkie pozostałe Jokery",
                    "Zmiana co zagrywaną rękę",
                    "{C:inactive}(Jokery nie zmieniają się po wybraniu Przeszkadzajki){}",
                },
            },
        }
    },
    misc = {
        dictionary = {
            a_abracadabra="Abrakadabra!",
            a_watered="Podlane!",
            a_plant_maxed="(osiągnięto maksimum)",
            a_reshuffled="Przetasowano",
            a_right="prawo",
            a_left="lewo",
            a_pop="Puf!",
            a_cards="karty",
            a_tag="znacznik",
        }
    }
}