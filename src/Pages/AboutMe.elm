module Pages.AboutMe exposing (Model, Msg, page)

import Gen.Params.Home_ exposing (Params)
import Html
import Html.Attributes as Attr
import Page
import Request
import Shared
import UI.Layout exposing (footer, navbar)
import Url exposing (Url)
import View exposing (View)


page : Shared.Model -> Request.With Params -> Page.With Model Msg
page shared req =
    Page.element
        { init = init shared req
        , update = update req
        , subscriptions = subscriptions
        , view = view req.url
        }



-- INIT


type alias Model =
    {}


init : Shared.Model -> Request.With Params -> ( Model, Cmd Msg )
init shared { params } =
    ( {}, Cmd.none )


type Msg
    = NoOp



-- UPDATE


update : Request.With Params -> Msg -> Model -> ( Model, Cmd Msg )
update req msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Url -> Model -> View Msg
view url model =
    { title = "About Me | Tycho brouwer"
    , body =
        [ navbar url
        , Html.div [ Attr.class "container about__page" ]
            [ Html.div [ Attr.class "about__section about__details" ]
                [ Html.img [ Attr.class "about__image", Attr.src "/images/tycho.webp", Attr.alt "Tycho Brouwer" ] []
                , Html.div []
                    [ Html.div [ Attr.class "about-category" ]
                        [ Html.p [ Attr.class "category-title text-secondary" ] [ Html.text "Contact" ]
                        , Html.p []
                            [ Html.a [ Attr.href "mailto:tycho.tbrouwer@gmail.com", Attr.target "_blank" ] [ Html.text "tycho.tbrouwer@gmail.com" ]
                            ]
                        , Html.p []
                            [ Html.a [ Attr.href "https://github.com/TychoBrouwer?tab=repositories", Attr.target "_blank" ] [ Html.text "github.com/TychoBrouwer" ]
                            ]
                        ]
                    , Html.div [ Attr.class "about-category" ]
                        [ Html.p [ Attr.class "category-title text-secondary" ] [ Html.text "Education" ]
                        , Html.p [] [ Html.text "Atheneum - Fortes Lyceum" ]
                        , Html.p [] [ Html.text "BSc Mechanical Engineering - Eindhoven University of Technology" ]
                        ]
                    ]
                ]
            , Html.div [ Attr.class "about__section about__me" ]
                [ Html.div [ Attr.class "row about__title" ]
                    [ Html.h2 [] [ Html.text "Hello, I'm" ]
                    , Html.h2 [ Attr.class "text-accent" ] [ Html.text "Tycho Brouwer" ]
                    ]
                , Html.div []
                    [ Html.p []
                        [ Html.text "I'm currently a mechanical engineering student at the Eindhoven University of Technology and I am interested in everything software and technology."
                        ]
                    , Html.p []
                        [ Html.text "My journey into technology begun when my grandfather dug up one of his first personal computers, a TRS-80 Color Computer, on which I wrote my first code in BASIC."
                        ]
                    , Html.p []
                        [ Html.span [ Attr.class "text-secondary" ] [ Html.text "Technology" ]
                        , Html.text "I was hooked on technology from that moment on. I started playing around with a Raspberry Pi, programming simple LEDs, displays, and small motors. A few years later I got my first real computer of my own running an Althon X4 860. This computer to this day is still used as a home server running self-hosted services such as Jellyfin, Traefik, Pi-Hole, and WireGuard."
                        ]
                    , Html.p []
                        [ Html.span [ Attr.class "text-secondary" ] [ Html.text "Programming" ]
                        , Html.text "Since my first taste with programming, I been learning and playing around with a wide range of programming languages. Starting with C++ on various microcontrollers and web development using HTML, JavaScript, and CSS. I moved to Python, PHP, SQL, TypeScript, and more recently Dart and Elm."
                        ]
                    , Html.p []
                        [ Html.span [ Attr.class "text-secondary" ] [ Html.text "Education" ]
                        , Html.text "I'm currently in my second year of my bachelor degree in mechanical engineering at the Eindhoven University of Technology. Aside from the engineering disciplines the study puts a heavy focus on project and challenge based learning."
                        ]
                    ]
                ]
            ]
        , footer
        ]
    }
