module Pages.Projects.Project_ exposing (Model, Msg, page)

import Api.Data exposing (Data)
import Api.Project exposing (Project)
import Components.Footer exposing (footer)
import Components.Navbar exposing (navbar)
import Components.Project exposing (..)
import Gen.Params.Projects.Project_ exposing (Params)
import Html
import Html.Attributes as Attr
import Page
import Request
import Shared
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
    , projectComponent : Maybe Project
    , project : Data Project
    }


init : Shared.Model -> Request.With Params -> ( Model, Cmd Msg )
init _ { params } =
    ( { projectName = params.project, projectComponent = Nothing, project = Api.Data.Loading }
    , Api.Project.get
        { projectName = params.project
        , onResponse = LoadedProject
        }
    )



-- UPDATE


type Msg
    = LoadedProject (Data Project)


update : Request.With Params -> Msg -> Model -> ( Model, Cmd Msg )
update _ msg model =
    case msg of
        LoadedProject projects ->
            case projects of
                Api.Data.Success a ->
                    ( { model
                        | projectComponent =
                            Just <|
                                a
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
                , Html.div [ Attr.id "project__page", Attr.class "container project__page" ]
                    [ Components.Project.view
                        { title = projectComponent.title
                        , projectComponent = projectComponent
                        , project = model.project
                        }
                    ]
                , footer
                ]

            Nothing ->
                [ navbar url, footer ]
    }
