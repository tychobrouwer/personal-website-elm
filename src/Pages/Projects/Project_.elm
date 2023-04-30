module Pages.Projects.Project_ exposing (Model, Msg, page)

import Api.Data exposing (Data)
import Api.Project exposing (Project)
import Components.Project exposing (..)
import Gen.Params.Projects.Project_ exposing (Params)
import Html
import Html.Attributes as Attr
import Page
import Request
import Shared
import UI exposing (Html)
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
    { projectName : String
    , projectComponent : Maybe ProjectComponent
    , project : Data Project
    }


init : Shared.Model -> Request.With Params -> ( Model, Cmd Msg )
init shared { params } =
    ( { projectName = params.project, projectComponent = Nothing, project = Api.Data.Loading }
    , Api.Project.get
        { projectName = params.project
        , onResponse = LoadedInitialProject
        }
    )



-- UPDATE


type Msg
    = LoadedInitialProject (Data Project)


update : Request.With Params -> Msg -> Model -> ( Model, Cmd Msg )
update req msg model =
    case msg of
        LoadedInitialProject project ->
            case project of
                Api.Data.Success a ->
                    ( { model
                        | projectComponent =
                            Just <|
                                { title = a.title
                                , image = a.image
                                , name = a.name
                                , markdown = a.markdown
                                , external = a.external
                                , internal = a.internal
                                }
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
    { title = (model.projectComponent |> Maybe.map .title |> Maybe.withDefault "Loading") ++ " | Tycho Brouwer"
    , body =
        case model.projectComponent of
            Just projectComponent ->
                [ navbar url
                , Components.Project.view
                    { title = projectComponent.title
                    , projectComponent = projectComponent
                    , project = model.project
                    }
                , footer
                ]

            Nothing ->
                [ navbar url, footer ]
    }
