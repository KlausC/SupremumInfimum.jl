
"""
    is_ordered(T::Type)

Return true iff leaftype `T` is ordered (either totally or partially).
Method: Check if method `<(::T,::T) is available at runtime
"""
is_ordered(::Type{T}) where {T<:Any} = checkm2(T, <) || checkm(T, isless)

"""
    is_partially_ordered(T::Type)

Return true iff leaftype `T` is partially ordered.
Method: Check if method `<(::T,::T) is available and `isless(::T,::T)` is not.
"""
is_partially_ordered(::Type{T}) where {T<:Any} = checkm2(T, <) && ! checkm(T, isless)

"""
    is_totally_ordered(T::Type)

Return true iff `T` is totally ordered.
Method: Check if methods `<(::T,::T) ans `isless(::T,::T)` are available.
"""
is_totally_ordered(::Type{T}) where {T<:Any} = checkm(T, isless)

"""
  is_iterable(::Type)

Return true iff leaf type `T` has methods `start(T)`, `next(T, Any)`, and `done(T, Any)`.
"""
is_iterable(::Type{T}) where {T<:Any} = hasmethod(start, (T,)) && hasmethod(done, (T, Any)) && hasmethod(next, (T, Any))
 
### Implementation details
# check method for (T,T) is callable
checkm(t::Type, f::Function) = hasmethod(f, (t, t))

# check if method is callable for (T,T) but it is not the default implementation fo (Any,Any)
function checkm2(t::Type, f::Function)
  try
    m1 = which(f, (t, t))
    m2 = which(f, (Any, Any))
    m1 != m2
  catch
    false
  end
end
"""
    hasmethod(f::Function, (type,...)) -> Bool

Check if method of the function `f` and given argument types is callable.
"""
function hasmethod(f::Function, t = Tuple)
  try
    which(f, t)
    true
  catch
    false
  end
end

"""
  partition(f, a::AbstractArray) -> (filter(f, a), filter( !f, a))

Partition the elements of array according to predicate function `f`.
The function is only evaluated once per array element.
"""
function partition(f, As::AbstractArray)
   sel = map(f, As)::AbstractArray{Bool}
   As[sel], As[.!(sel)]
 end
