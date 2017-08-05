using SupremumInfimum
using Base.Test

@testset "supremum/infimum   " begin include("supinf.jl") end
@testset "check ordering type" begin include("check.jl") end

