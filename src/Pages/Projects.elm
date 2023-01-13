module Pages.Projects exposing (Model, Msg, page)

import Gen.Params.Home_ exposing (Params)
import Gen.Route exposing (Route)
import Html
import Html.Attributes as Attr
import Page
import Request
import Shared
import UI.Layout
import UI exposing (Html)
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
    { title = "Tycho brouwer"
    , body =
        [ markdownSections
            [ ( "laptop"
              , """
## Build reliable applications with Elm
With __elm-spa__, you can create production-ready applications with one command:
"""
              , [ ( "GitHub Repo", Gen.Route.Projects__Section_ { section = "01-cli" } )
                  , ( "Explore the CLI", Gen.Route.Projects__Section_ { section = "01-cli" } )
                ]
              )
            ]
        ]
    }
markdownSections : List ( String, String, List ( String, Route ) ) -> Html msg
markdownSections sections =
    let
        viewSection i ( image, str, buttons ) =
            Html.section [ Attr.class "projects__section" ]
                [ Html.div [ Attr.class "projects__section-row container row", Attr.classList [ ( "align-right", modBy 2 i == 1 ) ] ]
                    [ Html.div [ Attr.class "col" ]
                        [ UI.markdown { withHeaderLinks = False } str
                        , Html.div [ Attr.class "row" ]
                            (List.map
                                (\( label, route ) -> Html.a [ Attr.class "button", Attr.href (Gen.Route.toHref route) ] [ Html.text label ])
                                buttons
                            )
                        ]
                        , Html.img [ Attr.class "projects__section-image", Attr.src ("/images/projects/" ++ image ++ ".svg") ] []
                    ]
                ]
    in
    Html.main_ [ Attr.class "col" ]
        (List.indexedMap viewSection sections)
