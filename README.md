# SupremumInfimum

[![Build Status](https://travis-ci.org/KlausC/SupremumInfimum.jl.svg?branch=master)](https://travis-ci.org/KlausC/SupremumInfimum.jl)
[![Coverage Status](https://coveralls.io/repos/KlausC/SupremumInfimum.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/KlausC/SupremumInfimum.jl?branch=master)
[![codecov.io](http://codecov.io/github/KlausC/SupremumInfimum.jl/coverage.svg?branch=master)](http://codecov.io/github/KlausC/SupremumInfimum.jl?branch=master)

This package tries to extend the usability of operation related to the canonical orders of types.
The methods `max`, `maximum`, `min`, and `minimum` are extended in several directions.
To distinct them from their Base.siblings and to give a hint on the new features, the names have been set to `sup` and `inf`.

1. `sup(a::T, b::T)` is identical to `max` for total ordering `T` and returns the least upper bound of `T` for partial ordering.

2. `sup(itr)` returns the lower bound of `eltype(itr)`, when iterable `itr` is empty.

3. `sup(T::Type)` returns the upper bound of `T`, if that exists.

4. `sup(f::Union{Function, Type}, itr)` behaves like `maximum(f, itr)` if itr is not empty, and returns the lower bound of the return type of `f`, if that exists.  

Corresponding statements are valid for `inf` in relation to `min` and the opposite bounds.



