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

        return t..string.reverse(final)
    end
end

return Function
