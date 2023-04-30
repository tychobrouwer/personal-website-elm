module Api.Token exposing
    ( Token
    , decoder, encode
    , get
    )

{-|

@docs Token
@docs decoder, encode
@docs get, put, post, delete

-}

import Http
import Json.Decode as Json
import Json.Encode as Encode


type Token
    = Token String


decoder : Json.Decoder Token
decoder =
    Json.map Token Json.string


encode : Token -> Json.Value
encode (Token token) =
    Encode.string token



-- HTTP HELPERS


get :
    { url : String
    , expect : Http.Expect msg
    }
    -> Cmd msg
get =
    request "GET" Http.emptyBody


request :
    String
    -> Http.Body
    ->
        { options
            | url : String
            , expect : Http.Expect msg
        }
    -> Cmd msg
request method body options =
    Http.request
        { method = method
        , headers = []
        , url = options.url
        , body = body
        , expect = options.expect
        , timeout = Just (1000 * 60) -- 60 second timeout
        , tracker = Nothing
        }
