module Monomials

export Monomial

export LexicographicOrder

export ReverseLexicographicOrder

export GradedLexicographicOrder

export GradedReverseLexicographicOrder

export EliminationOrder

export WeightOrder
export degree
export monomials

struct Monomial
    x::AbstractVector{String}
    α::AbstractVector{Integer}
end

abstract type MonomialOrder end


struct LexicographicOrder <: MonomialOrder
end

struct ReverseLexicographicOrder <: MonomialOrder
end

struct GradedLexicographicOrder <: MonomialOrder
end

struct GradedReverseLexicographicOrder <: MonomialOrder
end



function (m::Monomial)(x::AbstractVector{<:Real})
    return prod(x .^ m.α)
end

function degree(m::Monomial)
    return sum(m.α)
end

function monomials(x::AbstractVector{String}, d::Integer, mo::MonomialOrder)

    nvars = length(x)

    exponents = Iterators.filter(α -> 0 < sum(α) <= d, Iterators.product(repeat([0:d], nvars)...))

    m = map(exponents) do α
        Monomial(x, [α...])
    end

    return order(m, mo)

end

function order(m::AbstractVector{Monomial}, _::LexicographicOrder)

    function lt(a::Monomial, b::Monomial)
        if a.α != b.α
            idx = findfirst(!iszero, a.α .- b.α)
            return a.α[idx] < b.α[idx]
        end

        return false

    end

    return sort(m; lt=lt)
end

function order(m::AbstractVector{Monomial}, _::GradedLexicographicOrder)

    function lt(a::Monomial, b::Monomial)
        deg_a, deg_b = degree(a), degree(b)

        if deg_a != deg_b
            return deg_a < deg_b

        end

        if a.α != b.α
            idx = findfirst(!iszero, a.α .- b.α)
            return a.α[idx] < b.α[idx]
        end

        return false


    end

    return sort(m; lt=lt)
end

function order(m::AbstractVector{Monomial}, _::GradedReverseLexicographicOrder)

    function lt(a::Monomial, b::Monomial)
        deg_a, deg_b = degree(a), degree(b)

        if deg_a != deg_b
            return deg_a < deg_b

        end

        if a.α != b.α
            idx = findlast(!iszero, a.α .- b.α)
            return a.α[idx] > b.α[idx]
        end

        return false


    end

    return sort(m; lt=lt)
end



end
