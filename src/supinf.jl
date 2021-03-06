### part of package SupremumInfimum

import Base:  Callable, reduce_empty, mapreduce_empty, union, intersect

for (sup, supremum, inf, infimum, max, typemin, union, ubound, lbound) in
((:sup,:supremum,:inf,:infimum,:max,:typemin,:union,     "least upper bound",    "lower bound"),
 (:inf,:infimum,:sup,:supremum,:min,:typemax,:intersect, "greatest lower bound", "upper bound"))

  global supstring = string(supremum)
  global infstring = string(infimum)
  global ubound = ubound
  global lbound = lbound

@eval begin
"""
    $supstring(a::S, b::T)  

Calculate $ubound of `a` and `b`. If the type `promote_type(S,T)`
has a canonical partial order (implements `<` but does not implement `isless`),
the method must be overwritten for this type. If `isless` is defined, `$max` is called.
"""
($sup)(a::T, b::T) where {T<:Any} = ($max)(a, b)
($sup)(a::T, b::T) where {T<:Real} = ($max)(a, b)
($sup)(a::S, b::T) where {S<:Real,T<:Real} = ($max)(a, b)
($sup)(a::T, b::T) where {T<:AbstractString} = ($max)(a, b)
($sup)(a::S, b::T) where {S<:AbstractSet,T<:AbstractSet} = ($union)(a, b)
($sup)(a::S, b::T) where {S<:AbstractArray,T<:AbstractArray} = ($union)(a, b)

$sup(x::Real) = x

# This schould go to operators.jl:419
    ($sup)(a, b, c, xs...) = Base.afoldl(($sup), ($sup)(($sup)(a,b), c), xs...) 

"""
    $supstring(itr)

Calculate $ubound of the elements of collection `itr`.
If itr is empty, return a $lbound of the appropriate type.
"""
($supremum)(itr) = mapreduce(identity, ($sup), itr)

"""
    $supstring(f::Callable, itr)

Calculate $ubound of the elements of `f.(itr)`.
If itr is empty, return a $lbound of the return type of `f`.
"""
($supremum)(f::Callable, itr) = mapreduce(f, ($sup), itr)

######
# this is inspired by reduce.jl:243 ff
# note that we do not enforce the return type of ($infimum)
reduce_empty(::typeof(($sup)), T) = ($infimum)(T)

# derive inferred return type 
function mapreduce_empty(f, op::typeof(($supremum)), T)
  S = Core.Inference.return_type(f, (T,))
  ($infimum)(ifelse(S<:Union{}, Any, S))
end

"""
    $infstring(::Type{T})

Calculate $lbound for all elements of type `T`.
"""
($infimum)(::Type{T}) where {T<:Any} = ($typemin)(leaf_type(T)) # default behaviour

end # eval begin
end # for

infimum(::Type{T}) where {T<:AbstractSet} = leaf_type(T)()
infimum(::Type{String}) = ""
infimum(::Type{BigInt}) = IntInf

supremum(::Type{T}) where {T<:AbstractSet} = error("no upper bound defined (yet) for Set")
supremum(::Type{String}) = error("no upper bound defined for String")
supremum(::Type{BigInt}) = IntSup

"""
  leaf_type(::Type) -> ::Type

Return a default concrete subtype of argument.
"""

leaf_type(::Type{T}) where {T<:AbstractSet{U}} where {U<:Any} = isconcretetype(T) ? T : Set{U} 
leaf_type(::Type{T}) where {T<:AbstractArray{U,N}} where {U,N} = isconcretetype(T) ? T : Array{U,N} 
leaf_type(::Type{BigInt}) = BigInt
leaf_type(::Type{T}) where {T<:Signed} = isconcretetype(T) ? T : Int
leaf_type(::Type{T}) where {T<:Unsigned} = isconcretetype(T) ? T : UInt
leaf_type(::Type{T}) where {T<:Integer} = isconcretetype(T) ? T : Int
leaf_type(::Type{T}) where {T<:Real} = isconcretetype(T) ? T : Float64

