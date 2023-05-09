module Api.Project exposing
    ( Project
    , get
    , Section, getProjectName, projectDecoder
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
import Array
import Env exposing (domain)
import Json.Decode as Json
import Utils.Json exposing (withField)


type alias Project =
    { image : String
    , imageSecondary : String
    , imageLogo : String
    , name : String
    , title : String
    , description : String
    , sections : List { text : String, image : String }
    , links : List { name : String, route : String }
    }


emptyProject : Project
emptyProject =
    { image = ""
    , imageSecondary = ""
    , imageLogo = ""
    , name = ""
    , title = ""
    , description = ""
    , sections = []
    , links = []
    }


type alias Link =
    { name : String, route : String }


type alias Section =
    { text : String, image : String }


projectDecoder : Json.Decoder Project
projectDecoder =
    Utils.Json.record Project
        |> withField "image" Json.string
        |> withField "imageSecondary" Json.string
        |> withField "imageLogo" Json.string
        |> withField "name" Json.string
        |> withField "title" Json.string
        |> withField "description" Json.string
        |> withField "sections" sectionListDecoder
        |> withField "links" linkListDecoder


linkListDecoder : Json.Decoder (List Link)
linkListDecoder =
    Json.list
        (Json.map2 Link
            (Json.field "name" Json.string)
            (Json.field "route" Json.string)
        )


sectionListDecoder : Json.Decoder (List Section)
sectionListDecoder =
    Json.list
        (Json.map2 Section
            (Json.field "text" Json.string)
            (Json.field "image" Json.string)
        )


get :
    { projectName : String
    , onResponse : Data Project -> msg
    }
    -> Cmd msg
get options =
    Api.Token.get
        { url = domain ++ "/api/projects.json"
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
            emptyProject


getProjectName : Int -> List Project -> String
getProjectName idx projects =
    Array.fromList projects
        |> Array.get idx
        |> Maybe.withDefault emptyProject
        |> .name
