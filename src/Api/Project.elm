module Api.Project exposing
    ( Project, decoder
    , get
    -- , Listing
    -- , list
    )

{-|

@docs Project, decoder
@docs Listing, updateArticle
@docs list, feed
@docs get, create, update, delete
@docs favorite, unfavorite

-}

-- import Api.Project.Filters as Filters exposing (Filters)

import Api.Data exposing (Data)
import Api.Token exposing (Token)
import Http
import Iso8601
import Json.Decode as Json
import Json.Encode as Encode
import Time
import Utils.Json exposing (withField)


type alias Project =
    { image : String
    , name : String
    , title : String
    , markdown : String
    , internal : List { name : String, route : String }
    , external : List { name : String, route : String }
    }


type alias Link =
    { name : String, route : String }


decoder : Json.Decoder Project
decoder =
    Utils.Json.record Project
        |> withField "image" Json.string
        |> withField "name" Json.string
        |> withField "title" Json.string
        |> withField "markdown" Json.string
        |> withField "external" linkListDecoder
        |> withField "internal" linkListDecoder


linkListDecoder : Json.Decoder (List Link)
linkListDecoder =
    Json.list
        (Json.map2 Link
            (Json.field "name" Json.string)
            (Json.field "route" Json.string)
        )


get :
    { projectName : String
    , onResponse : Data Project -> msg
    }
    -> Cmd msg
get options =
    Api.Token.get
        { url = "http://localhost:1234/api/projects/" ++ options.projectName ++ ".json"
        , expect =
            Api.Data.expectJson options.onResponse
                (Json.field "project" decoder)
        }
