module Api.Project exposing
    ( Project
    , get
    , projectDecoder
    )

{-|

@docs Project, decoder
@docs Listing, updateArticle
@docs list, feed
@docs get, create, update, delete
@docs favorite, unfavorite

-}

import Api.Data exposing (Data)
import Api.Token
import Json.Decode as Json
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


projectDecoder : Json.Decoder Project
projectDecoder =
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
        { url = "http://localhost:1234/api/projects.json"
        , expect =
            Api.Data.expectJson options.onResponse
                (Json.field "projects" (Json.list projectDecoder)
                    |> Json.map (findProject options.projectName)
                )
        }


findProject : String -> List Project -> Project
findProject name projects =
    List.filter (\project -> project.name == name) projects
        |> List.head
        |> Maybe.withDefault
            { image = ""
            , name = ""
            , title = ""
            , markdown = ""
            , internal = []
            , external = []
            }
