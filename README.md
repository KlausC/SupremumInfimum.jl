# SupremumInfimum

[![Build Status](https://travis-ci.org/KlausC/SupremumInfimum.jl.svg?branch=master)](https://travis-ci.org/KlausC/SupremumInfimum.jl)
[![Coverage Status](https://coveralls.io/repos/KlausC/SupremumInfimum.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/KlausC/SupremumInfimum.jl?branch=master)
[![codecov.io](http://codecov.io/github/KlausC/SupremumInfimum.jl/coverage.svg?branch=master)](http://codecov.io/github/KlausC/SupremumInfimum.jl?branch=master)

This package tries to extend the usability of operation related to the canonical orders of types.

The methods `max`, `maximum`, `min`, and `minimum` are extended in several directions.
To give a hint on the new features, the names have been set to `sup` and `inf`.

1. `sup(a::T, b::T)` returns the least upper bound of `a` and `b` for partial ordering.

2. `sup(itr)` returns the lower bound of `eltype(itr)`, when iterable `itr` is empty.

3. `sup(f::Union{Function, Type}, itr)` returns the lower bound of the return type of `f`, if that exists.  

4. `sup(T::Type)` returns the upper bound of `T`, if that exists.


Corresponding statements are valid for `inf` in relation to `min` and the opposite bounds.

Generally, `sup` behaves like `max` or `maximum` according to the argument types. For total orders and non-empty collections the return values are identical.

The canonical order of a type is controlled by the functions
`isless` with `isequal` for total orderings, and `<` with `==` for partial orderings.

A type `T` is considered as having a canonical total ordering, if the methods `isless(::T,::T)`
is defined. It is assumed, that in this case `<(::T,::T)` is also defined and yields
identical results. Only exception are floating point types, which make differences for
negative zeros and NaN.

A type `T` is considered as having a canonical partial ordering, if the method `<(::T,::T)`
is defined, while `isless(::T,::T)` is not.

A type `T` is ordered, if `<(::T,::T)` is defined, which covers the two cases above.
If only `isless(::T,::T)` is defined, that is considered an error.

The functions `is_totally_ordered`, `is_partially_ordered`, `is_ordered` account for this.

usage:
```jl

julia> using SupremumInfimum

julia> sup(IntSet([1,42]), IntSet([2,42]))
IntSet([1, 2, 42])
```



