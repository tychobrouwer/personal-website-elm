module Components.Project exposing (view)

import Api.Data exposing (Data)
import Api.Project exposing (Project, Section)
import Env exposing (domain)
import Html exposing (Html)
import Html.Attributes as Attr
import UI exposing (htmlIf)


view :
    { title : String
    , projectComponent : Project
    , project : Data Project
    }
    -> Html msg
view options =
    Html.div [ Attr.id "project__page", Attr.class "container project__page" ]
        [ Html.div [ Attr.class "project__header project__section" ]
            [ Html.div [ Attr.class "project__section-left" ]
                [ Html.div
                    [ Attr.class "project__title" ]
                    [ projectImage options.projectComponent.imageLogo "project__logo"
                    , Html.h1 [ Attr.class "project__name" ] [ Html.text options.projectComponent.title ]
                    ]
                , Html.p [ Attr.class "project__section-text" ] [ Html.text options.projectComponent.description ]
                ]
            , Html.img [ Attr.class "project__section-image", Attr.src (domain ++ "/images/projects/" ++ options.projectComponent.image ++ ".webp") ] []
            ]
        , projectSections options.projectComponent.sections
        ]


projectSections : List Section -> Html msg
projectSections sections =
    Html.div [ Attr.class "project__sections" ]
        (List.indexedMap
            (\idx section ->
                Html.div [ Attr.class "project__section" ]
                    (if modBy 2 idx == 0 then
                        [ Html.div [ Attr.class "project__section-left" ]
                            [ Html.p [ Attr.class "project__section-text" ] [ Html.text section.text ] ]
                        , Html.div [ Attr.class "project__section-right" ]
                            [ projectImage section.image "project__section-image" ]
                        ]

                     else
                        [ Html.div [ Attr.class "project__section-left" ]
                            [ projectImage section.image "project__section-image" ]
                        , Html.div [ Attr.class "project__section-right" ]
                            [ Html.p [ Attr.class "project__section-text" ] [ Html.text section.text ] ]
                        ]
                    )
            )
            sections
        )


projectImage : String -> String -> Html msg
projectImage image classes =
    htmlIf
        (Html.img
            [ Attr.class classes
            , Attr.src (domain ++ "/images/projects/" ++ image ++ ".webp")
            ]
            []
        )
        (image /= "")
