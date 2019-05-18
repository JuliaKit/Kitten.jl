module JuliaKit

import Random
import JSON

export hello, domath, greet

hello(who::String) = "Hello, $who"

domath(x::Number) = x + 5

greet() = print("Hello ", Random.randstring(8))

end
