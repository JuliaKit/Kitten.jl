using Documenter, Kit

makedocs(
  modules = [Kit],
  sitename="JuliaKit.jl",
  authors="Billgo",
  pages = [
    "index.md"
  ]
)

deploydocs(
  repo = "github.com/juliakit/Kit.jl.git",
  target = "build",
  osname = "linux",
  julia = "1.1",
  deps = nothing,
  make = nothing
)