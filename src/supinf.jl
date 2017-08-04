### part of package SupremumInfimum

import Base:  Callable, mr_empty, union, intersect

for (supremum, infimum, max, typemin, union, ubound, lbound) in
    ((:sup,:inf,:max,:typemin,:union,     "least upper bound",    "lower bound"),
     (:inf,:sup,:min,:typemax,:intersect, "greatest lower bound", "upper bound"))

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
($supremum)(a::T, b::T) where {T<:Any} = ($max)(a, b)
($supremum)(a::T, b::T) where {T<:Real} = ($max)(a, b)
($supremum)(a::S, b::T) where {S<:Real,T<:Real} = ($max)(a, b)
($supremum)(a::T, b::T) where {T<:AbstractString} = ($max)(a, b)
($supremum)(a::S, b::T) where {S<:AbstractSet{U},T<:AbstractSet{U}} where U = ($union)(a, b)
($supremum)(a::S, b::T) where {S<:AbstractArray,T<:AbstractArray} = ($union)(a, b)


# This schould go to operators.jl:419
    ($supremum)(a, b, c, xs...) = Base.afoldl(($supremum), ($supremum)(($supremum)(a,b), c), xs...) 

"""
    $supstring(itr)

Calculate $ubound of the elements of collection `itr`.
If itr is empty, return a $lbound of the appropriate type.
"""
($supremum)(itr) = mapreduce(identity, ($supremum), itr)

"""
    $supstring(f::Callable, itr)

Calculate $ubound of the elements of `f.(itr)`.
If itr is empty, return a $lbound of the return type of `f`.
"""
($supremum)(f::Callable, itr) = mapreduce(f, ($supremum), itr)

######
# this is inspired by reduce.jl:243 ff
# note that we do not enforce the return type of ($infimum)
mr_empty(::typeof(identity), ::typeof(($supremum)), T) = ($infimum)(T)

# derive inferred return type 
function mr_empty(f, op::typeof(($supremum)), T)
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

supremum(::Type{T}) where {T<:AbstractSet} = error("no upper bound defined (yet) for Set")
supremum(::Type{String}) = error("no upper bound defined for String")

"""
  leaf_type(::Type) -> ::Type

Return a default concrete subtype of argument.
"""

leaf_type(::Type{T}) where {T<:AbstractSet{U}} where {U<:Any} = isleaftype(T) ? T : Set{U} 
leaf_type(::Type{T}) where {T<:AbstractArray{U,N}} where {U,N} = isleaftype(T) ? T : Array{U,N} 
leaf_type(::Type{BigInt}) = error("lower/upper bounds not (yet) implemented for BigInt")
leaf_type(::Type{T}) where {T<:Signed} = isleaftype(T) ? T : Int64
leaf_type(::Type{T}) where {T<:Unsigned} = isleaftype(T) ? T : UInt64
leaf_type(::Type{T}) where {T<:Integer} = isleaftype(T) ? T : Int64
leaf_type(::Type{T}) where {T<:Real} = isleaftype(T) ? T : Float64

# aliases for the main functions
const supremum = sup
const infimum = inf

