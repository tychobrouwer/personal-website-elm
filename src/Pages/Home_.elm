module Pages.Home_ exposing (Model, Msg, page)

import Api.Data exposing (Data)
import Api.Project exposing (Project, getProjectName)
import Api.Projects
import Components.Footer exposing (footer)
import Components.Navbar exposing (navbar)
import Env exposing (domain)
import Gen.Params.Home_ exposing (Params)
import Html
import Html.Attributes as Attr
import Page
import Request
import Shared
import UI exposing (Html)
import Url exposing (Url)
import View exposing (View)


page : Shared.Model -> Request.With Params -> Page.With Model Msg
page shared req =
    Page.element
        { init = init shared
        , update = update req
        , subscriptions = subscriptions
        , view = view req.url
        }



-- INIT


type alias Model =
    { project : Data (List Project)
    , projectsData : List Project
    }


init : Shared.Model -> ( Model, Cmd Msg )
init _ =
    ( { project = Api.Data.Loading, projectsData = [] }
    , Api.Projects.get
        { onResponse = LoadedProjects }
    )


type Msg
    = LoadedProjects (Data (List Project))



-- UPDATE


update : Request.With Params -> Msg -> Model -> ( Model, Cmd Msg )
update _ msg model =
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


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Url -> Model -> View Msg
view url model =
    { title = "Tycho brouwer"
    , body =
        [ navbar url
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
                , Html.div [ Attr.id "home__about_me__image" ]
                    [ Html.img [ Attr.src (domain ++ "/images/tu_eindhoven_logo.svg"), Attr.alt "TU Eindhoven" ] []
                    , Html.div [ Attr.class "row" ]
                        [ Html.p []
                            [ Html.span [] [ Html.text "University of Technology" ]
                            , Html.span [ Attr.class "text-accent" ] [ Html.text "Eindhoven" ]
                            ]
                        ]
                    , Html.div [ Attr.class "row" ]
                        [ Html.p []
                            [ Html.span [] [ Html.text "Bachelor" ]
                            , Html.span [ Attr.class "text-accent" ] [ Html.text "Mechanical Engineering" ]
                            , Html.span [] [ Html.text "2021 - now" ]
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
    }


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
