
import Base: promote_rule, min, max

"""
Define universal infimum- and supremum values for `Integer` types.
"""
abstract type IntLimit <: Real end

struct Infimum <: IntLimit end
struct Supremum <: IntLimit end

const IntInf = Infimum()
const IntSup = Supremum()

name(::Infimum) = "-Inf"
name(::Supremum) = "Inf"

Base.show(io::IO, x::IntLimit) = print(io, "Int(" * name(x) * ")")

typeinf(::Type{T}) where T<:Union{Integer,Rational} = IntInf
typesup(::Type{T}) where T<:Union{Integer,Rational} = IntSup
typeinf(::Type{T}) where T<:Unsigned = zero(T)
typeinf(::Type{T}) where T<:Real = typemin(T)
typesup(::Type{T}) where T<:Real = typemax(T)

typeinf(::T) where T<:Real = typeinf(T)
typesup(::T) where T<:Real = typesup(T)

promote_rule(::Type{<:IntLimit}, ::Type{BigInt}) = Union{IntLimit,BigInt}
promote_rule(::Type{<:IntLimit}, T::Type{<:Real}) = T


for t in [Int64, Int32, Int16, Int128, Int8, UInt64, UInt32, UInt16, UInt128, UInt8, Float64, Float32, BigFloat]
@eval begin
    (::Type{$t})(::Infimum) = typemin($t)
    (::Type{$t})(::Supremum) = typemax($t)
end
end

(::Type{BigInt})(x::Infimum) = x
(::Type{BigInt})(x::Supremum) = x

# integer arithmetic
import Base:    ==, isless, +, -, *, /, ÷, %

min(i::Infimum, ::BigInt) = i
min(::BigInt, i::Infimum) = i
min(::Supremum, r::BigInt) = r
min(r::BigInt, ::Supremum) = r
max(::Infimum, r::BigInt) = r
max(r::BigInt, ::Infimum) = r
max(s::Supremum, r::BigInt) = s
max(r::BigInt, s::Supremum) = s

==(a::IntLimit, b::IntLimit) = a === b
==(a::IntLimit, b::Real) = isinf(b) && (b < 0) == (a === IntInf)
==(b::Real, a::IntLimit) = isinf(b) && (b < 0) == (a === IntInf)

isless(::Infimum, b::Infimum) = false
isless(::Supremum, b::Supremum) = false
isless(::Supremum, b::Infimum) = false
isless(::Infimum, b::Supremum) = true
isless(a::Infimum, b::T) where T<:AbstractFloat = b != infimum(T)
isless(b::AbstractFloat, a::Infimum) = false
isless(a::Supremum, b::AbstractFloat) = false
isless(b::T, a::Supremum) where T<:AbstractFloat = b != supremum(T)

-(::Infimum) = IntSup
-(::Supremum) = IntInf

+(a::T, ::T) where T<:IntLimit = a
+(a::IntLimit, b::IntLimit) = throw(ArgumentError("inf - inf"))
+(a::IntLimit, ::Real) = a
+(::Real, a::IntLimit) = a
-(a::T, b::T) where T<:IntLimit = a + (-b)
-(a::Infimum, ::Supremum) = IntInf
-(a::Supremum, ::Infimum) = IntSup
-(a::IntLimit, ::Real) = a
-(::Real, a::IntLimit) = -a

