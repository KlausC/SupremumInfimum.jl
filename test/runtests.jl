using SupremumInfimum
using Base.Test

# write your own tests here
@test leaf_type(Int) == Int64
@test leaf_type(UInt8) == UInt8
@test leaf_type(Real) == Float64
@test leaf_type(Integer) == Int64
@test leaf_type(Unsigned) == UInt64


