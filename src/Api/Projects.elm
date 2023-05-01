module Api.Projects exposing (get)

import Api.Data exposing (Data)
import Api.Project exposing (Link, Project, projectDecoder)
import Api.Token
import Json.Decode as Json
import Utils.Json exposing (withField)


{-|

@docs Project, decoder
@docs Listing, updateArticle
@docs list, feed
@docs get, create, update, delete
@docs favorite, unfavorite

-}
linkListDecoder : Json.Decoder (List Link)
linkListDecoder =
    Json.list
        (Json.map2 Link
            (Json.field "name" Json.string)
            (Json.field "route" Json.string)
        )


get :
    { onResponse : Data (List Project) -> msg
    }
    -> Cmd msg
get options =
    Api.Token.get
        { url = "http://localhost:1234/api/projects.json"
        , expect =
            Api.Data.expectJson options.onResponse
                (Json.field "projects" (Json.list projectDecoder))
        }
