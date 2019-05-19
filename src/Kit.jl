module Kit

export hello

include("Financial/Financial.jl")
include("Mathematical/Mathematical.jl")

hello(who::String) = "Hello, $who"

end # module
