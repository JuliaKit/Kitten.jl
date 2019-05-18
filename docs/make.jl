using Documenter, Kit

makedocs(modules = [Kit], sitename = "Kit.jl")

deploydocs(
    repo = "github.com/JuliaKit/Kit.jl.git",
)
