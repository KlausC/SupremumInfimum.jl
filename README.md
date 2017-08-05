# SupremumInfimum

[![Build Status](https://travis-ci.org/KlausC/SupremumInfimum.jl.svg?branch=master)](https://travis-ci.org/KlausC/SupremumInfimum.jl)
[![Coverage Status](https://coveralls.io/repos/KlausC/SupremumInfimum.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/KlausC/SupremumInfimum.jl?branch=master)
[![codecov.io](http://codecov.io/github/KlausC/SupremumInfimum.jl/coverage.svg?branch=master)](http://codecov.io/github/KlausC/SupremumInfimum.jl?branch=master)

This package tries to extend the usability of operation related to the canonical orders of types.

The methods `max`, `maximum`, `min`, and `minimum` are extended in several directions.
To give a hint on the new features, the names have been set to `sup`, `supremum`, `inf`, and `infimum`.

1. `sup(a::T, b::T)` returns the least upper bound of `a` and `b` for partial ordering.

2. `supremum(itr)` returns the lower bound of `eltype(itr)`, when iterable `itr` is empty.

3. `supremum(f::Union{Function, Type}, itr)` returns the lower bound of the return type of `f`, if that exists.  

4. `supremum(T::Type)` returns the upper bound of `T`, if that exists.


Corresponding statements are valid for `inf` in relation to `min` and the opposite bounds.

Generally, `sup` behaves like `max` and `supremum` like `maximum`. For total orders and non-empty collections the return values are identical.


### Types and orders

Each Type canonically has exactly one of the order kinds

* totally ordered
* partially ordered
* all other unordered types


The canonical order of a type is controlled by the functions
`isless` with `isequal` for total orderings, and `<` and == for partial orderings.

A type `T` is considered as having a canonical total ordering, iff the method `isless(::T,::T)`
is defined. It is assumed, that in this case `<(::T,::T)` is also defined and yields
identical results. Only exception are floating point types, which make differences for
negative zeros and NaN.

A type `T` is considered as having a canonical partial ordering, iff the method `<(::T,::T)`
is defined, while `isless(::T,::T)` is not and `<(::T,::T)` != `(<(::Any,::Any)`. The last
method is the default implementation, which tries to call `isless` and would fail in this case.

A type `T` is ordered, if one of the two cases above applies.

The functions `is_totally_ordered`, `is_partially_ordered`, `is_ordered` account for this.

Despite of these definitions, the floating point numbers with `<` and `==` form a total order
on the real numbers, too. In this case, the `-0.0` and `+0.0` are considered as equivalent,
while in the canonical case they are considered as two distinct numbers.

### usage

```jl

julia> using SupremumInfimum

julia> sup(IntSet([1,42]), IntSet([2,42]))
IntSet([1, 2, 42])
```



