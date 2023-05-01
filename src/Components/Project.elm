module Components.Project exposing (ProjectComponent, view)

import Api.Data exposing (Data)
import Api.Project exposing (Project)
import Html exposing (Html)
import Html.Attributes as Attr


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
    Html.div []
        [ Html.h1 [] [ Html.text options.projectComponent.title ]
        , Html.p [] [ Html.text options.projectComponent.markdown ]
        , Html.img [ Attr.src options.projectComponent.image ] []
        ]
