using SupremumInfimum
using Base.Test

# write your own tests here
@test leaf_type(Int) == Int
@test leaf_type(UInt8) == UInt8
@test leaf_type(Real) == Float64
@test leaf_type(Integer) == Int
@test leaf_type(Unsigned) == UInt

@test sup(Set{Int}[]) == Set{Int}()



@testset "Real type $T basics" for T in [subtypes(AbstractFloat); subtypes(Signed); subtypes(Unsigned)]
  
  let  E = one(T), Z = zero(T), IP = typemax(T), IN = typemin(T)

  @test sup(T[]) == IN
  @test inf(T[]) == IP # Inf - Note the names match!
  @test sup(E) == E
  @test inf(E) == E
  @test sup([Z]) == Z
  @test inf([Z]) == Z
  @test sup(IP) == IP
  @test inf(IP) == IP
  @test sup([IN]) == IN
  @test inf([IN]) == IN

  @test sup(E, Z) == E
  @test inf(E, Z) == Z
  @test sup(Z, E) == E
  @test inf(Z, E) == Z
  @test sup([E, Z]) == E
  @test inf([E, Z]) == Z
  @test sup([Z, E]) == E
  @test inf([Z, E]) == Z
  @test sup([E, IP]) == IP
  @test inf([E, IP]) == E
  @test sup([IP, Z]) == IP
  @test inf([IP, Z]) == Z
  @test sup([E, IN]) == E
  @test inf([E, IN]) == IN
  @test sup([IN, Z]) == Z
  @test inf([IN, Z]) == IN
  end
end

@testset "Set operations" begin
  let Z = Set{AbstractFloat}(), E = Set([Float16(1.0), 2]), A = Set([1.0, 3])

#    @test inf(Z, E) == inf(E, Z) == Z
 #   @test sup(Z, E) == sup(Z, E) == E
  #  @test sup(E, A, Z) == sup(Z, A, E) == Set[1.0, 2, 3] 
   # @test inf(E, A, Z) == inf(Z, A, E) == Set{Float64}()

  end
end
@test inf(Float64[]) == Inf # Note the names match!
@test sup(Float64[]) == -Inf # Note the names match!
@test sup(IntSet([1,42]), IntSet([2,42])) == IntSet([1, 2, 42])
@test inf(IntSet([1,42]), IntSet([2,42])) == IntSet([42])

