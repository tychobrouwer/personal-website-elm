module Pages.Projects exposing (Model, Msg, page)

import Gen.Route exposing (Route)
import Html
import Html.Attributes as Attr
import Page
import ProjectData exposing (projectData)
import Request
import Shared
import UI exposing (Html)
import UI.Layout
import View exposing (View)


page : Shared.Model -> Request.With params -> Page.With Model Msg
page =
    UI.Layout.pageFullWidth
        { view = view
        }


type alias Model =
    UI.Layout.Model


type alias Msg =
    UI.Layout.Msg


view : View Msg
view =
    { title = "Projects | Tycho brouwer"
    , body =
        [ markdownSections projectData ]
    }


markdownSections :
    List
        { image : String
        , markdown : String
        , internal : List ( String, Route )
        , external : List ( String, String )
        }
    -> Html msg
markdownSections sections =
    let
        viewSection _ { image, markdown, internal, external } =
            Html.section [ Attr.class "projects__section" ]
                [ Html.div [ Attr.class "projects__section-row container row" ]
                    [ Html.div [ Attr.class "col" ]
                        [ UI.markdown { withHeaderLinks = False } markdown
                        , Html.div [ Attr.class "row" ]
                            (List.map
                                (\( label, route ) -> Html.a [ Attr.class "button", Attr.href (Gen.Route.toHref route) ] [ Html.text label ])
                                internal
                                ++ List.map
                                    (\( label, url ) -> Html.a [ Attr.class "button", Attr.href url ] [ Html.text label ])
                                    external
                            )
                        ]
                    , Html.img [ Attr.class "projects__section-image", Attr.src ("images/projects/" ++ image ++ ".webp"), Attr.alt (String.replace "_" " " image) ] []
                    ]
                ]
    in
    Html.main_ [ Attr.class "col" ]
        (List.indexedMap viewSection sections)
