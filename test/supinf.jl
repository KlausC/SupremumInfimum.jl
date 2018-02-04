using SupremumInfimum
using InteractiveUtils
using Test

# write your own tests here
@test leaf_type(Int) == Int
@test leaf_type(UInt8) == UInt8
@test leaf_type(Real) == Float64
@test leaf_type(Integer) == Int
@test leaf_type(Unsigned) == UInt

@test supremum(Set{Int}[]) == Set{Int}()

@testset "Real type $T basics" for T in [subtypes(AbstractFloat); subtypes(Signed); subtypes(Unsigned)]

  let  E = one(T), Z = zero(T), IP = supremum(T), IN = infimum(T)

  @test supremum(T[]) == IN
  @test infimum(T[]) == IP # Inf - Note the names match!
  @test sup(E) == E
  @test inf(E) == E
  @test supremum([Z]) == Z
  @test infimum([Z]) == Z
  @test sup(IP) == IP
  @test inf(IP) == IP
  @test supremum([IN]) == IN
  @test infimum([IN]) == IN

  @test sup(E, Z) == E
  @test inf(E, Z) == Z
  @test sup(Z, E) == E
  @test inf(Z, E) == Z
  @test supremum([E, Z]) == E
  @test infimum([E, Z]) == Z
  @test supremum([Z, E]) == E
  @test infimum([Z, E]) == Z
  @test supremum([E, IP]) == IP
  @test infimum([E, IP]) == E
  @test supremum([IP, Z]) == IP
  @test infimum([IP, Z]) == Z
  @test supremum([E, IN]) == E
  @test infimum([E, IN]) == IN
  @test supremum([IN, Z]) == Z
  @test infimum([IN, Z]) == IN
  end
end

@testset "Set operations" begin
  let Z = Set{AbstractFloat}(), E = Set([Float16(1.0), 2]), A = Set([1.0, 3])

  @test inf(Z, E) == inf(E, Z) == Z
  @test sup(Z, E) == sup(Z, E) == E
  @test sup(E, A, Z) == Set([1.0, 2, 3]) 
  @test sup(Z, A, E) == Set([1.0, 2, 3]) 
  @test inf(E, A, Z) == Set{Float64}()
  @test inf(Z, A, E) == Set{Float64}()

  @test supremum([E, A]) == Set([1.0, 2, 3])
  @test supremum(maximum, [E, A]) === 3.0
  @test_throws ArgumentError supremum(maximum, [E, Z]) === 2.0
  @test supremum(supremum, [E, Z]) === 2.0
  @test supremum(length, [E, Z]) === 2
  @test infimum(length, [E, Z]) === 0

  end
end
@test infimum(Float64[]) == Inf # Note the names match!
@test supremum(Float64[]) == -Inf
@test sup(BitSet([1,42]), BitSet([2,42])) == BitSet([1, 2, 42])
@test inf(BitSet([1,42]), BitSet([2,42])) == BitSet([42])

