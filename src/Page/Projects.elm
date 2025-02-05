module Page.Projects exposing (Model, Msg, init, update, view)

import Api.Data exposing (Data)
import Api.Project exposing (Project)
import Api.Projects
import Browser.Navigation as Nav
import Components.Footer exposing (footer)
import Components.Navbar exposing (navbar)
import Env exposing (domain)
import Html exposing (Html)
import Html.Attributes as Attr


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
        [ navbar "/projects"
        , markdownSections model.projectsData
        , footer
        ]


markdownSections :
    List Project
    -> Html msg
markdownSections projects =
    let
        projectSection project =
            Html.section [ Attr.class "projects__section" ]
                [ Html.div [ Attr.class "projects__section-row container row" ]
                    [ Html.div [ Attr.class "col" ]
                        [ Html.h2 [ Attr.class "projects__title" ] [ Html.text project.title ]
                        , Html.p [ Attr.class "projects__section-text" ] [ Html.text project.description ]
                        , Html.div [ Attr.class "row row-buttons" ]
                            (List.map
                                (\link -> Html.a [ Attr.class "button", Attr.href link.route ] [ Html.text link.name ])
                                project.links
                            )
                        ]
                    , Html.img [ Attr.class "projects__section-image", Attr.src (domain ++ "/images/projects/" ++ project.imageSecondary ++ ".webp"), Attr.alt (String.replace "_" " " project.image) ] []
                    ]
                ]
    in
    Html.main_ [ Attr.class "col" ]
        (List.map projectSection (List.filter (\project -> List.member "old" project.tags == False) projects))
