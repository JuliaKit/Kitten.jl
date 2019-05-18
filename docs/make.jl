using Documenter, JuliaKit

makedocs(modules = [JuliaKit], sitename = "JuliaKit.jl")

deploydocs(
    repo = "github.com/JuliaKit/JuliaKit.jl.git",
)
