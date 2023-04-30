module Components.Project exposing (ProjectComponent, view)

import Api.Data exposing (Data)
import Api.Project exposing (Project)
import Html exposing (..)
import Html.Attributes exposing (attribute, class, placeholder, src, type_, value)
import Html.Events as Events


type alias ProjectComponent =
    { image : String
    , name : String
    , title : String
    , markdown : String
    , internal : List { name : String, route : String }
    , external : List { name : String, route : String }
    }


view :
    { title : String
    , projectComponent : ProjectComponent
    , project : Data Project
    }
    -> Html msg
view options =
    div []
        [ h1 [] [ text options.projectComponent.title ]
        , p [] [ text options.projectComponent.markdown ]
        , img [ src options.projectComponent.image ] []
        ]
