using Documenter, Kit

makedocs(
  repo = "https://github.com/juliakit/Kit.jl",
  modules = [Kit],
  sitename="Kit.jl",
  authors="Billgo",
  pages = [
    "index.md"
  ]
)

deploydocs(
  repo = "github.com/juliakit/Kit.jl.git",
  branch = "gh-pages",
  devbranch = "master",
  target = "build",
  deps = nothing,
  make = nothing
)