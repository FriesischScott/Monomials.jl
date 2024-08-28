Monomials.jl
============

![Build Status](https://github.com/FriesischScott/Monomials.jl/actions/workflows/ci.yml/badge.svg) [![Coverage Status](https://codecov.io/gh/FriesischScott/Monomials.jl/graph/badge.svg?token=MFK6LJBRNK)](https://codecov.io/gh/FriesischScott/Monomials.jl)

A simple apackage to generate and order vectors of monomials. It is designed as an alternative to the [MultivariatePolynomials.jl](https://github.com/JuliaAlgebra/MultivariatePolynomials.jl) ecosystem if all you require is monomials not fully fledged polynomials.

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
