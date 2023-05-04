module Components.Carousel exposing (carousel)

import Api.Project exposing (Project)
import Env exposing (domain)
import Html exposing (Html)
import Html.Attributes as Attr


carousel : List Project -> Html msg
carousel sections =
    let
        viewSection project =
            Html.a
                [ Attr.id project.name
                , Attr.class "carousel__section"
                , Attr.href ("/projects/" ++ project.name)
                ]
                [ Html.div [ Attr.class "carousel__section-col" ]
                    [ Html.h2 [ Attr.class "carousel__section-title" ] [ Html.text project.title ]
                    , Html.img
                        [ Attr.class "carousel__section-image"
                        , Attr.src ("/images/projects/" ++ project.image ++ ".webp")
                        , Attr.alt (String.replace "_" " " project.image)
                        ]
                        []
                    ]
                ]
    in
    Html.div [ Attr.class "row", Attr.id "carousel" ]
        (List.map viewSection sections)
