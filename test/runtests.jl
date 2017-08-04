using SupremumInfimum
using Base.Test

# write your own tests here
@test leaf_type(Int) == Int64
@test leaf_type(UInt8) == UInt8
@test leaf_type(Real) == Float64
@test leaf_type(Integer) == Int64
@test leaf_type(Unsigned) == UInt64

@test sup(Set{Int}[]) == Set{Int}()
@test inf(Float64[]) == Inf # Note the names match!
@test sup(IntSet([1,42]), IntSet([2,42])) == IntSet([1, 2, 42])
@test inf(IntSet([1,42]), IntSet([2,42])) == IntSet([42])
