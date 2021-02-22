# NOTE: v1.3 checks are for if you want to test on pre-1.3 w/o the Arrow.jl dependency
VERSION > v"1.3" && using Arrow

using Base.Iterators: product
using Dates
using Documenter: doctest
using Infinity: Infinite, InfExtendedReal, InfExtendedTime, InfMinusInfError, ∞
using Intervals
using Intervals: isfinite
using Serialization: deserialize
using Test
using TimeZones

const BOUND_PERMUTATIONS = product((Closed, Open), (Closed, Open))

include("test_utils.jl")

@testset "Intervals" begin
    include("inclusivity.jl")
    include("endpoint.jl")
    include("interval.jl")
    include("anchoredinterval.jl")
    include("comparisons.jl")
    include("plotting.jl")
    VERSION >= v"1.3" && include("arrow.jl")

    # Note: The output of the doctests currently requires a newer version of Julia
    # https://github.com/JuliaLang/julia/pull/34387
    # The doctests fail on x86, so only run them on 64-bit hardware
    if VERSION >= v"1.5.0-DEV.163" && Sys.WORD_SIZE == 64
        doctest(Intervals)
    else
        @warn "Skipping doctests"
    end
end
