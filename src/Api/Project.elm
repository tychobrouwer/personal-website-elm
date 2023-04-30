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



-- type alias Listing =
--     { projects : List Project
--     , page : Int
--     , totalPages : Int
--     }
-- -- ENDPOINTS
-- list :
--     { page : Int
--     , onResponse : Data Listing -> msg
--     }
--     -> Cmd msg
-- list options =
--     Api.Token.get
--         { url = "https://www.tbrouwer.com/api/projects/" ++ String.fromInt options.page ++ ".json"
--         , expect =
--             Api.Data.expectJson options.onResponse
--                 (paginatedDecoder options.page)
--         }


get :
    { projectName : String
    , onResponse : Data Project -> msg
    }
    -> Cmd msg
get options =
    Api.Token.get
        { url = "https://www.tbrouwer.com/api/projects/" ++ options.projectName ++ ".json"
        , expect =
            Api.Data.expectJson options.onResponse
                (Json.field "project" decoder)
        }



-- INTERNALS
-- paginatedDecoder : Int -> Json.Decoder Listing
-- paginatedDecoder page =
--     let
--         multipleArticles : List Project -> Int -> Listing
--         multipleArticles projects count =
--             { projects = projects
--             , page = page
--             , totalPages = count
--             }
--     in
--     Json.map2 multipleArticles
--         (Json.field "projects" (Json.list decoder))
--         (Json.field "projectsCount" Json.int)
