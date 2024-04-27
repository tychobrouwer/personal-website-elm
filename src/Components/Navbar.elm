module Components.Navbar exposing (navbar)

import Html exposing (Html)
import Html.Attributes as Attr
import UI


navbar : String -> Html msg
navbar active =
    let
        navLink : { text : String, route : String } -> Html msg
        navLink options =
            let
                href : String
                href = options.route
            in
            Html.a
                [ Attr.class "bold link-hover"
                , Attr.href href
                , Attr.classList
                    [ ( "text-accent"
                      , href == active
                      )
                    ]
                ]
                [ Html.div [] [ Html.text options.text ] ]
    in
    Html.header [ Attr.class "header" ]
        [ Html.div [ Attr.class "container row spread" ]
            [ Html.div [ Attr.class "row fill-width" ]
                [ Html.div
                    [ Attr.href "/", Attr.class "header__logo" ]
                    [ UI.logo ]
                , Html.nav [ Attr.class "row almost-width space" ]
                    [ navLink { text = "Home", route = "/" }
                    , navLink { text = "Projects", route = "/projects" }
                    ]
                ]
            , Html.nav [ Attr.class "row icon-nav" ]
                [ UI.iconLink { text = "GitHub", icon = UI.icons.github, url = "https://github.com/TychoBrouwer" }
                , UI.iconLink { text = "Email", icon = UI.icons.email, url = "mailto:tycho.tbrouwer@gmail.com" }
                , UI.iconLink { text = "Linkedin", icon = UI.icons.linkedin, url = "https://www.linkedin.com/in/tycho-brouwer-6306ba274/" }
                ]
            ]
        ]
