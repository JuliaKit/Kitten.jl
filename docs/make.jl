using Documenter, Kit

makedocs(format = Documenter.HTML(
  prettyurls = get(ENV, "CI", nothing) == "true",
  assets = ["assets/favicon.ico","assets/logo.png"]    ),
  sitename="Kit.jl",
  modules = [Kit],
  pages = [
    "index.md"
  ])

get(ENV, "CI", nothing) == "true" ? deploydocs(
  repo = "github.com/juliakit/Kit.jl.git",
) : nothing;