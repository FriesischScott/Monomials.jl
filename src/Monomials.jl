module Monomials

export Monomial

export LexicographicOrder

export GradedLexicographicOrder

export GradedReverseLexicographicOrder


export degree
export monomials

"""
    Monomial(x, α)

Greate a Monomial from a vector of variables `x` and associated degrees vector `α`.

# Examples
```julia-repl
julia> Monomial(["x", "y"], [1, 2])
xy^2
```
"""
struct Monomial
    x::AbstractVector{String}
    α::AbstractVector{Integer}
end

abstract type MonomialOrder end


struct LexicographicOrder <: MonomialOrder
end

struct GradedLexicographicOrder <: MonomialOrder
end

struct GradedReverseLexicographicOrder <: MonomialOrder
end


function (m::Monomial)(x::AbstractVector{<:Real})
    return prod(x .^ m.α)
end

function (m::Monomial)(x::AbstractMatrix{<:Real})
    return map(xᵢ -> m(xᵢ), eachcol(x))
end

function (mvec::AbstractVector{Monomial})(x::AbstractVector{<:Real})
    return [m(x) for m in mvec]
end

function (mvec::AbstractVector{Monomial})(x::AbstractMatrix{<:Real})
    return vcat([m(x)' for m in mvec]...)
end

"""
    degree(m::Monomial)

Computes the degree of a monomial, which is the sum of the degrees of its variables.
"""
function degree(m::Monomial)
    return sum(m.α)
end

"""
    monomials(x::AbstractVector{String}, d::Integer, mo::MonomialOrder; include_zero::Bool=false)

Computes all monomials of the variables `x` up to degree `d` ordered in monomial order `mo`.

Pass `include_zero=true` to include the zero degree monomial.

# Examples
```julia-repl
julia> monomials(["x","y"], 2, LexicographicOrder(); include_zero=true)
5-element Vector{Monomial}:
1
y
 y²
 x
 xy
 x²
```
"""
function monomials(x::AbstractVector{String}, d::Integer, mo::MonomialOrder; include_zero::Bool=false)

    nvars = length(x)

    lb = include_zero ? -1 : 0

    exponents = Iterators.filter(α -> lb < sum(α) <= d, Iterators.product(repeat([0:d], nvars)...))

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


    end

    return sort(m; lt=lt)
end

include("show.jl")

end
