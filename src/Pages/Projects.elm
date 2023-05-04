module Pages.Projects exposing (Model, Msg, page)

import Api.Data exposing (Data)
import Api.Project exposing (Project)
import Api.Projects
import Components.Footer exposing (footer)
import Components.Navbar exposing (navbar)
import Env exposing (domain)
import Gen.Params.Projects exposing (Params)
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
    { title = "Projects | Tycho brouwer"
    , body =
        [ navbar url
        , markdownSections model.projectsData
        , footer
        ]
    }


markdownSections :
    List Project
    -> Html msg
markdownSections sections =
    let
        viewSection project =
            Html.section [ Attr.class "projects__section" ]
                [ Html.div [ Attr.class "projects__section-row container row" ]
                    [ Html.div [ Attr.class "col" ]
                        [ Html.h2 [ Attr.class "projects__section-title" ] [ Html.text project.title ]
                        , UI.markdown { withHeaderLinks = False } project.markdown
                        , Html.div [ Attr.class "row" ]
                            (List.map
                                (\link -> Html.a [ Attr.class "button", Attr.href link.route ] [ Html.text link.name ])
                                project.links
                            )
                        ]
                    , Html.img [ Attr.class "projects__section-image", Attr.src ("/images/projects/" ++ project.imageSecondary ++ ".webp"), Attr.alt (String.replace "_" " " project.image) ] []
                    ]
                ]
    in
    Html.main_ [ Attr.class "col" ]
        (List.map viewSection sections)
