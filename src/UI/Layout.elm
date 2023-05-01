module UI.Layout exposing
    ( footer
    , navbar
    )

{-|

@docs Model, init
@docs Msg, update
@docs viewDefault, viewDocumentation

-}

-- import UI.Sidebar

import Gen.Route as Route exposing (Route)
import Html exposing (Html)
import Html.Attributes as Attr
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI
import Url exposing (Url)
import View exposing (View)


navbar : Url -> Html msg
navbar url =
    let
        navLink : { text : String, route : Route } -> Html msg
        navLink options =
            let
                href : String
                href =
                    Route.toHref options.route
            in
            Html.a
                [ Attr.class "bold link-hover"
                , Attr.href href
                , Attr.classList
                    [ ( "text-accent"
                      , if href == "/" then
                            href == url.path

                        else
                            String.startsWith href url.path
                      )
                    ]
                ]
                [ Html.div [] [ Html.text options.text ] ]
    in
    Html.header [ Attr.class "header" ]
        [ Html.div [ Attr.class "container row spread" ]
            [ Html.div [ Attr.class "row fill-width" ]
                [ Html.a
                    [ Attr.class "header__logo"
                    , Attr.classList
                        [ ( "text-accent"
                          , if url.path == "/" then
                                True

                            else
                                False
                          )
                        ]
                    , Attr.href "/"
                    ]
                    [ UI.logo ]
                , Html.nav [ Attr.class "row almost-width space" ]
                    [ navLink { text = "Projects", route = Route.Projects }
                    , navLink { text = "About Me", route = Route.AboutMe }
                    ]
                ]
            , Html.nav [ Attr.class "row icon-nav" ]
                [ UI.iconLink { text = "GitHub", icon = UI.icons.github, url = "https://github.com/TychoBrouwer?tab=repositories" }
                , UI.iconLink { text = "Email", icon = UI.icons.email, url = "mailto:tycho.tbrouwer@gmail.com" }
                , UI.iconLink { text = "Linkedin", icon = UI.icons.linkedin, url = "https://www.linkedin.com/in/tycho-brouwer-6306ba274/" }

                -- , UI.iconLink { text = "Mastodon", icon = UI.icons.mastodon, url = "https://hackaday.social/@tycho" }
                ]
            ]
        ]


footer : Html msg
footer =
    Html.div [ Attr.class "footer__zone" ]
        [ Html.footer [ Attr.class "footer" ]
            [ Html.div [ Attr.class "row spread container" ]
                [ Html.a [ Attr.href "https://github.com/TychoBrouwer/personal_website", Attr.target "_blank", Attr.class "link hidden-mobile" ] [ Html.text "Site source code" ]
                , Html.p [ Attr.class "p" ] [ Html.text "Tycho Brouwer" ]
                ]
            ]
        ]
