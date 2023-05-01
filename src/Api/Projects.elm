module Api.Projects exposing (get)

import Api.Data exposing (Data)
import Api.Project exposing (Project, projectDecoder)
import Api.Token
import Json.Decode as Json


{-|

@docs Project, decoder
@docs Listing, updateArticle
@docs list, feed
@docs get, create, update, delete
@docs favorite, unfavorite

-}
get :
    { onResponse : Data (List Project) -> msg
    }
    -> Cmd msg
get options =
    Api.Token.get
        { url = "http://www.tbrouwer.com/api/projects.json"
        , expect =
            Api.Data.expectJson options.onResponse
                (Json.field "projects" (Json.list projectDecoder))
        }
