"""
Implement supremum and infimum functions as extensions of maximum and minimum.
Cover the corner case of empty collections and partially ordered types. 
"""

module SupremumInfimum

export supremum, infimum, sup, inf, leaf_type
export is_ordered, is_partially_ordered, is_totally_ordered, is_iterable

include("supinf.jl")
include("check.jl")

end # module

