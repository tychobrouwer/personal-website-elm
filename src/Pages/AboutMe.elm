module Pages.AboutMe exposing (Model, Msg, page)

-- import Gen.Route exposing (Route)
-- import UI exposing (Html)

import Html
import Html.Attributes as Attr
import Page
import Request
import Shared
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
    { title = "About Me | Tycho brouwer"
    , body =
        [ Html.div [ Attr.class "container" ]
            [ Html.div [ Attr.class "about__section" ]
                [ Html.div [ Attr.class "row about__title" ]
                    [ Html.h2 [] [ Html.text "Hello, I'm" ]
                    , Html.h1 [] [ Html.text "Tycho Brouwer" ]
                    ]
                , Html.div []
                    [ Html.p []
                        [ Html.text "I'm currently a mechanical engineering student at the Technische Universiteit Eindhoven in the Netherlands and interested in everything from software to control engineering."
                        ]
                    , Html.p []
                        [ Html.text "My journey into technology begun at a young age when my grandfather dug up one of his first personal computers, a TRS-80 Color Computer, on which I wrote my first code in BASIC."
                        ]
                    , Html.p []
                        [ Html.span [ Attr.class "text-accent" ] [ Html.text "Technology" ]
                        , Html.text "I was hooked on technology from that moment on. I started playing around with a Raspberry Pi my dad got me programming LEDs, displays, and motors. A few years later I got my first real computer of my own running an Althon X4 860. This computer to this day is still used as a home server running self-hosted services such as Jellyfin, Traefik, Pi-Hole, and WireGuard."
                        ]
                    , Html.p []
                        [ Html.span [ Attr.class "text-accent" ] [ Html.text "Programming" ]
                        , Html.text "Since my first taste with programming, I been learning and playing around with a wide range of programming languages. Starting with C++ on various microcontrollers and web development using HTML, JavaScript, and CSS. I quickly moved on to Python, PHP, SQL, TypeScript, SASS, and more recently Dart and Elm."
                        ]
                    , Html.p []
                        [ Html.span [ Attr.class "text-accent" ] [ Html.text "Education" ]
                        , Html.text "I'm currently in my second year of my bachelor degree in mechanical engineering at the Technische Universiteit Eindhoven in the Netherlands. Here subjects from thermodynamics, dynamics, mechanics, material properties, and control theory are taught. Aside from the engineering disciplines the study puts a heavy focus on project and challenge based learning. This has learned me how to tackle real-life problems in addition to skills such as presenting, reflecting, and collaborating."
                        ]
                    ]
                ]
            ]
        ]
    }
