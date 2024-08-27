const superscripts = ("¹", "²", "³", "⁴", "⁵", "⁶", "⁷", "⁸", "⁹")

function Base.show(io::IO, m::Monomial)
    str = map(zip(m.x, m.α)) do (x, d)
        if d == 0
            return ""
        elseif d == 1
            return x
        else
            return join([x, superscripts[d]])
        end
    end

    print(io, join(str))

    return nothing
end
