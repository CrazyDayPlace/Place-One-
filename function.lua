local Function = {} do

    function Function:HexColor(q, t)
        local int = math.floor(q.r*255)*256^2+math.floor(q.g*255)*256+math.floor(q.b*255)
        local current = int
        local final = ""
        local hexChar = {"a", "b", "c", "d", "e", "f"}

        repeat local remainder = current % 16
            local char = tostring(remainder)
            if remainder >= 10 then
                char = hexChar[1 + remainder - 10]
            end

            current = math.floor(current/16)
            final = final..char
        until current <= 0

        return (t or "#") .. string.reverse(final)
    end

    function Function:RoundNumber(q)
        local DigitsInNumber = math.max(math.ceil(math.log10(q+1)),1)
        local FormattedNumber
        local NotationToUse
        local TableOfLetters = {"", "K", "M", "B", "T"}

        local NumberOfDigitsToShow = 1.5*(DigitsInNumber%3)^2 - 3.5*(DigitsInNumber%3) + 5
        FormattedNumber = string.sub(tostring(q/10^(DigitsInNumber-1)),1,NumberOfDigitsToShow)
        local FinalNumber = string.sub(FormattedNumber*(10^((DigitsInNumber-1)%3)),1,NumberOfDigitsToShow)

        if DigitsInNumber == 3 then
            FinalNumber = tostring(math.ceil(tonumber(FinalNumber)))
        end

        NotationToUse = FinalNumber..TableOfLetters[math.ceil(DigitsInNumber/3)]

        return NotationToUse
    end



    function Function:RaidUpdate()
        local q =
        {
            "Divine Guardian Raid",
            "Blue Devil Raid",
            "Psycho Student Raid",
            "Buff Boy Raid",
            "Warlord Raid",
            "King of Curses Raid",
            "Black Pasta Raid",
            "Cosmic Wolfman Raid",
            "Joto Raid",
            "Matsuri Raid",
            "Tonjuro Sun God Raid",
            "Vio Raid",
            "Demon Lord Raid",
            "Ichini Fullbring Raid",
            "Roku Ultra Instinct Raid",
            "Chainsaw Raid",
            "Nardo Beast Raid",
            "Cursed Sage Raid",
            "Red Emperor Raid",
            "Tengu Raid",
            "Yomichi Raid",
            "Christmas Raid",
            "Infinity Nojo Raid",
            "Combat Titan Raid",
            "Esper Raid",
            "Gear 5 Fluffy Raid",
            "Tengoku Raid",
            "Hirito Raid",
            "Titan Raid"
        }
        return q
    end
end

return Function
