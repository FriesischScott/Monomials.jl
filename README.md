Monomials.jl
============

![Build Status](https://github.com/FriesischScott/Monomials.jl/actions/workflows/ci.yml/badge.svg) [![Coverage Status](https://codecov.io/gh/FriesischScott/Monomials.jl/graph/badge.svg?token=MFK6LJBRNK)](https://codecov.io/gh/FriesischScott/Monomials.jl)

A simple apackage to generate order and evaluate vectors of monomials. It is designed as an alternative to the [MultivariatePolynomials.jl](https://github.com/JuliaAlgebra/MultivariatePolynomials.jl) ecosystem if all you require is monomials not fully fledged polynomials.

The core functionality is exposed through the `monomials` function. It generates all monomials of the given variables up to a defined maximum degree and sorts them in the requested order. Current monomial orders are:

- LexicographicOrder
- GradedLexicographicrder
- GradedReverseLexicographicOrder

The following returns the monomials  of two variables with a maximum degree of 2 in lexicographic order.

```julia
monomials(["x","y"], 2, LexicographicOrder())
```

```
5-element Vector{Monomial}:
 y
 y²
 x
 xy
 x²
```

it is possible to include the zero-degree monomial by passing the `include_zero=true` option

```julia
m = monomials(["x","y"], 2, LexicographicOrder(); include_zero=true)
```

```
6-element Vector{Monomial}:
 1
 y
 y²
 x
 xy
 x²
```

Monomials can be evaluated by passing a `Vector`.

```julia
    m = Monomial(["x", "y"], [1, 2])
    m([2, 3])
```

For convenience, a single monomial can be evaluated at multiple points by passing a `Matrix`. In this case, the points are expected to be the columns of the given matrix.

```julia
m = Monomial(["x", "y"], [1, 2])
m(rand(2, 5))
```

Finally, it is possible to evaulate all monomials in a vector for one or more points.

```julia
m = monomials((["x", "y"], 2, LexcicographicOrder())
m(rand(2, 5))
```
