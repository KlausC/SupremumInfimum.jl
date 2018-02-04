using SupremumInfimum
using Test

@testset "supremum-infimum   " begin include("supinf.jl") end
@testset "check ordering type" begin include("check.jl") end
@testset "integer limits"      begin include("limits.jl") end

