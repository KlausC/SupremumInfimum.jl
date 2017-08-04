# SupremumInfimum

[![Build Status](https://travis-ci.org/KlausC/SupremumInfimum.jl.svg?branch=master)](https://travis-ci.org/KlausC/SupremumInfimum.jl)

# [![Coverage Status](https://coveralls.io/repos/KlausC/SupremumInfimum.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/KlausC/SupremumInfimum.jl?branch=master)

[![codecov.io](http://codecov.io/github/KlausC/SupremumInfimum.jl/coverage.svg?branch=master)](http://codecov.io/github/KlausC/SupremumInfimum.jl?branch=master)

This package tries to extend the usability of operation related to the canonical orders of types.
The methods `max`, `maximum`, `min`, and `minimum` are extended in several directions.
To distinct them from their Base.siblings and to give a hint on the new features, the names have been set to `sup` and `inf`.

1. `sup(a::T, b::T)` is identical to `max` if T has a total ordering and delivers the least upper bound if T has only a partial ordering. Same for `inf`.

2. `sup(itr)` delivers a sensible value when `itr` is empty. Sane for `inf`.


