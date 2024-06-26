module Kitten

include("core.jl")
using .Core
include("instances.jl")
using .Instances
include("extensions/load.jl")

import HTTP: Request, Response
using .Core: Context, History, Server, Nullable
using .Core: GET, POST, PUT, DELETE, PATCH


const CONTEXT = Ref{Context}(Context())

import Base: get
include("methods.jl")
include("deprecated.jl")

macro oxidise()
    quote
        import Kitten
        import Kitten: PACKAGE_DIR, Context, Nullable
        import Kitten: GET, POST, PUT, DELETE, PATCH, STREAM, WEBSOCKET

        const CONTEXT = Ref{Context}(Context())
        include(joinpath(PACKAGE_DIR, "methods.jl"))

        nothing # to hide last definition
    end |> esc
end

export @oxidise, @get, @post, @put, @patch, @delete, @route,
    @staticfiles, @dynamicfiles, @cron, @repeat, @stream, @websocket,
    get, post, put, patch, delete, route, stream, websocket,
    serve, serveparallel, terminate, internalrequest,
    resetstate, instance, staticfiles, dynamicfiles,
    # Util
    redirect, queryparams, formdata, format_sse_message,
    html, text, json, file, xml, js, css, binary,
    # Extractors
    Path, Query, Header, Json, JsonFragment, Form, Body, extract, validate,
    # Docs
    configdocs, mergeschema, setschema, getschema, router,
    enabledocs, disabledocs, isdocsenabled,
    # Tasks & Cron
    starttasks, stoptasks, cleartasks,
    startcronjobs, stopcronjobs, clearcronjobs,
    # Common HTTP Types
    Request, Response, Stream, WebSocket
end
