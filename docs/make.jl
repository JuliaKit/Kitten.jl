using Documenter, Kit

makedocs(
  repo = "https://github.com/JuliaKit/Kit.jl",
  modules = [Kit],
  sitename="Kit.jl",
  authors="Billgo",
  pages = [
    "index.md"
  ]
)

get(ENV, "CI", nothing) == "true" ? deploydocs(
  repo = "github.com/JuliaKit/Kit.jl.git",
  branch = "gh-pages",
  devbranch = "master",
  target = "build",
  deps = nothing,
  make = nothing
) : nothing;