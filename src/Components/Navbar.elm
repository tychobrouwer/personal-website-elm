module Components.Navbar exposing (navbar)

import Gen.Route as Route exposing (Route)
import Html exposing (Html)
import Html.Attributes as Attr
import UI
import Url exposing (Url)


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
