
struct TO end
struct PO end

import Base: <, isless
isless(::TO, ::TO) = false
<(::PO, ::PO) = false

@testset "is $x ordered" for (x, y) in
  ((Int, true), (Real, true), (Number, false), (Set{Integer}, true), (IntSet, true),
   (Any, false), (Array, false), (TO, true), (PO, true))
  
   @test is_ordered(x) == y
end

@testset "is $x partially ordered" for (x, y) in
  ((Int, false), (Real, false), (Number, false), (Set{Integer}, true), (IntSet, true),
   (Any, false), (Array, false), (TO, false), (PO, true))
  
   @test is_partially_ordered(x) == y
end

@testset "is $x totally ordered" for (x, y) in
  ((Int, true), (Real, true), (Number, false), (Set{Integer}, false), (IntSet, false),
   (Any, false), (Array, false), (TO, true), (PO, false))
  
   @test is_totally_ordered(x) == y
end
