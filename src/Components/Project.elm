module Components.Project exposing (view)

import Api.Data exposing (Data)
import Api.Project exposing (Project)
import Env exposing (domain)
import Html exposing (Html)
import Html.Attributes as Attr


view :
    { title : String
    , projectComponent : Project
    , project : Data Project
    }
    -> Html msg
view options =
    Html.div []
        [ Html.h1 [ Attr.class "project__title" ] [ Html.text options.projectComponent.title ]
        , Html.p [] [ Html.text options.projectComponent.markdown ]
        , Html.img [ Attr.src (domain ++ "/images/projects/" ++ options.projectComponent.image ++ ".webp") ] []
        ]
