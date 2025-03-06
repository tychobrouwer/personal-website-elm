module Components.Project exposing (view)

import Api.Data exposing (Data)
import Api.Project exposing (Link, Project, Section)
import Env exposing (domain)
import Html exposing (Html)
import Html.Attributes as Attr
import UI exposing (htmlIf)
import Html exposing (section)


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
            , if options.projectComponent.image /= "" then
                Html.img [ Attr.class "project__section-image", Attr.src (domain ++ "/images/projects/" ++ options.projectComponent.image ++ ".webp") ] []
              else
                Html.text ""
                
            ]
        , Html.div [ Attr.class "row row-buttons" ]
            (List.map
                (\link -> Html.a [ Attr.class "button", Attr.href link.route ] [ Html.text link.name ])
                (List.filter isReadMore options.projectComponent.links)
            )
        , projectSections options.projectComponent.sections
        ]


isReadMore : Link -> Bool
isReadMore n =
    if n.name == "Read More" then
        False

    else
        True


projectSections : List Section -> Html msg
projectSections sections =
    Html.div [ Attr.class "project__sections" ]
        (List.indexedMap
            (\idx section ->
                Html.div [ Attr.class "project__section" ]
                    (if section.text == "" && section.image == "" then
                        [ Html.div [ Attr.class "project__section-images" ]
                            (List.map
                                (\item ->
                                    projectImage item "project__section-image"
                                )
                                section.images
                            )
                        ]
                        
                     else if section.image == "" then
                        [ Html.p [ Attr.class "project__section-text" ] [ Html.text section.text ] ]

                     else if modBy 2 idx == 0 then
                        [ Html.p [ Attr.class "project__section-left project__section-text" ] [ Html.text section.text ]
                        , projectImage section.image "project__section-image"
                        ]

                     else
                        [ projectImage section.image "project__section-left project__section-image"
                        , Html.p [ Attr.class "project__section-text" ] [ Html.text section.text ]
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
