module Page.Home exposing (Model, Msg, init, update, view)

import Api.Data exposing (Data)
import Api.Project exposing (Project)
import Api.Projects
import Browser.Navigation as Nav
import Components.Footer exposing (footer)
import Components.Navbar exposing (navbar)
import Env exposing (domain)
import Html exposing (Html)
import Html.Attributes as Attr
import UI


type alias Model =
    { project : Data (List Project)
    , projectsData : List Project
    , navKey : Nav.Key
    }


type Msg
    = LoadedProjects (Data (List Project))


init : Nav.Key -> ( Model, Cmd Msg )
init navKey =
    ( { project = Api.Data.Loading, projectsData = [], navKey = navKey }
    , Api.Projects.get
        { onResponse = LoadedProjects }
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoadedProjects projects ->
            case projects of
                Api.Data.Success a ->
                    ( { model
                        | projectsData = a
                      }
                    , Cmd.none
                    )

                _ ->
                    ( model, Cmd.none )



-- VIEWS


view : Model -> Html Msg
view model =
    Html.div []
        [ navbar "/"
        , Html.div [ Attr.id "home__introduction", Attr.class "container" ]
            [ UI.hero
                { title = "Tycho Brouwer"
                , description =
                    [ "A site for showcasing my projects"
                    , "current, finished, and never finished."
                    ]
                }
            , Html.div [ Attr.class "introduction" ]
                [ Html.p [ Attr.class "p" ]
                    [ Html.text "I am a mechanical engineering student at the Eindhoven University of Technology," ]
                , Html.p [ Attr.class "p" ]
                    [ Html.text "interested in everything software and technology related." ]
                ]
            ]
        , Html.div [ Attr.class "divider" ]
            [ Html.div [ Attr.class "divider__line" ] []
            , Html.div [ Attr.class "divider__box" ]
                [ Html.div [ Attr.class "divider__arrow" ] [ UI.icons.down ]
                ]
            ]
        , Html.div [ Attr.id "home__about_me", Attr.class "container" ]
            [ Html.div
                [ Attr.class "row section__title" ]
                [ Html.h2 [] [ Html.text "About" ]
                , Html.h2 [ Attr.class "text-accent" ] [ Html.text "me" ]
                ]
            , Html.div [ Attr.id "home__about_me__content", Attr.class "row" ]
                [ Html.div [ Attr.id "home__about_me__text" ]
                    [ Html.p []
                        [ Html.text "I'm currently a third year mechanical engineering student at the Eindhoven University of Technology and I am interested in everything science, software, and technology."
                        ]
                    , Html.p []
                        [ Html.text "My journey into technology begun when my grandfather dug up one of his first personal computers, a TRS-80 Color Computer, on which I wrote my first code in BASIC."
                        ]
                    , Html.p []
                        [ Html.span [ Attr.class "text-accent" ] [ Html.text "Technology" ]
                        , Html.text "I was hooked on technology from that moment on. I started playing around with a Raspberry Pi, programming simple LEDs, displays, and small motors. A few years later I got my first real computer of my own running an Althon X4 860. This computer to this day is still used as a home server running self-hosted services such as Jellyfin, Traefik, Pi-Hole, and WireGuard."
                        ]
                    , Html.p []
                        [ Html.span [ Attr.class "text-accent" ] [ Html.text "Programming" ]
                        , Html.text "Since my first taste with programming, I been learning and playing around with a wide range of programming languages. Starting with C++ on various microcontrollers and web development using HTML, JavaScript, and CSS. I moved to Python, PHP, SQL, TypeScript, and more recently Dart and Elm."
                        ]
                    , Html.p []
                        [ Html.span [ Attr.class "text-accent" ] [ Html.text "Education" ]
                        , Html.text "I'm currently in my first year of my master degree in mechanical engineering at the Eindhoven University of Technology. Aside from the engineering disciplines the study puts a heavy focus on project and challenge based learning."
                        ]
                    , Html.p []
                        [ Html.span [ Attr.class "text-accent" ] [ Html.text "Student Board" ]
                        , Html.text "At the start of the 2023/2024 academic year I started playing badminin at the student association E.S.B.V. Panache. During the year, I decided I wanted to contribute back to the association and joined the board at the start of the 2024/2025 year as the secretary. As one of the most international student associations of the university, I have been able to improve my communication skills and interact with a wide range of people. As part of the board I helped organise the annual tournament, members weekend, and various fun activities for the members."
                        ]
                    ]
                , Html.div [ Attr.id "home__about_me__image" ]
                    [ Html.div [ Attr.class "row" ]
                        [ Html.p []
                            [ Html.span [] [ Html.text "Fortes Lyceum Gorinchem" ] ]
                        ]
                    , Html.div [ Attr.class "row" ]
                        [ Html.p []
                            [ Html.span [] [ Html.text "VWO" ]
                            , Html.span [ Attr.class "text-accent" ] [ Html.text "NT&NG Technasium" ]
                            , Html.span [] [ Html.text "2015 - 2021" ]
                            ]
                        ]
                    , Html.img [ Attr.src (domain ++ "/images/tu_eindhoven_logo.svg"), Attr.alt "TU Eindhoven" ] []
                    , Html.div [ Attr.class "row" ]
                        [ Html.p []
                            [ Html.span [ Attr.class "text-accent" ] [ Html.text "Eindhoven" ]
                            , Html.span [] [ Html.text "University of Technology" ]
                            ]
                        ]
                    , Html.div [ Attr.class "row" ]
                        [ Html.p []
                            [ Html.span [] [ Html.text "BSc" ]
                            , Html.span [ Attr.class "text-accent" ] [ Html.text "Mechanical Engineering" ]
                            , Html.span [] [ Html.text "2021 - 2025" ]
                            ]
                        ]
                    , Html.div [ Attr.class "row" ]
                        [ Html.p []
                            [ Html.span [] [ Html.text "MSc" ]
                            , Html.span [ Attr.class "text-accent" ] [ Html.text "Mechanical Engineering" ]
                            , Html.span [] [ Html.text "2025 - now" ]
                            ]
                        ]
                    ]
                ]
            ]
        , Html.div [ Attr.class "divider" ]
            [ Html.div [ Attr.class "divider__line" ] []
            , Html.div [ Attr.class "divider__box" ]
                [ Html.div [ Attr.class "divider__arrow" ] [ UI.icons.down ]
                ]
            ]
        , Html.div [ Attr.id "home__project_preview", Attr.class "container" ]
            [ Html.div
                [ Attr.class "row section__title" ]
                [ Html.h2 [] [ Html.text "Recent" ]
                , Html.h2 [ Attr.class "text-accent" ] [ Html.text "projects" ]
                ]
            , projectPreviews model.projectsData
            ]
        , footer
        ]


projectPreviews :
    List Project
    -> Html msg
projectPreviews projects =
    let
        projectPreview project =
            Html.a [ Attr.class "projects__preview", Attr.href (Maybe.withDefault emptyRoute (List.head project.links)).route ]
                [ Html.img
                    [ Attr.class "projects__preview_image", Attr.src (domain ++ "/images/projects/" ++ project.image ++ ".webp"), Attr.alt (String.replace "_" " " project.image) ]
                    []
                ]
    in
    Html.div [ Attr.class "projects__preview_container" ]
        (List.map projectPreview (projects |> List.take 3))


emptyRoute :
    { name : String
    , route : String
    }
emptyRoute =
    { name = "home"
    , route = ""
    }
