using Kit

if VERSION < v"0.7.0-DEV.2005"
    using Base.Test
else
    using Test
end

include("Hello.jl")
include("MathToolkit.jl")