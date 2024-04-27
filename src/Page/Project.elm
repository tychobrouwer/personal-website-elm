module Page.Project exposing (Model, Msg, init, update, view)

import Api.Data exposing (Data)
import Api.Project exposing (Project)
import Browser.Navigation as Nav
import Components.Footer exposing (footer)
import Components.Navbar exposing (navbar)
import Components.Project exposing (..)
import Html exposing (Html)
import Html.Attributes as Attr


type alias Model =
    { projectName : String
    , projectComponent : Maybe Project
    , project : Data Project
    , navKey : Nav.Key
    }


type Msg
    = LoadedProject (Data Project)


init : String -> Nav.Key -> ( Model, Cmd Msg )
init projectId navKey =
    ( { projectName = projectId
      , projectComponent = Nothing
      , project = Api.Data.Loading
      , navKey = navKey
      }
    , Api.Project.get
        { projectName = projectId
        , onResponse = LoadedProject
        }
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
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



-- VIEWS


view : Model -> Html Msg
view model =
    case model.projectComponent of
        Just projectComponent ->
            Html.div []
                [ navbar "/projects"
                , Html.div [ Attr.class "container project__back" ]
                    [ Html.a
                        [ Attr.class "button project__back-button", Attr.href "/projects" ]
                        [ Html.text "Back" ]
                    ]
                , Components.Project.view
                    { title = projectComponent.title
                    , projectComponent = projectComponent
                    , project = model.project
                    }
                , footer
                ]

        Nothing ->
            Html.div [] [ navbar "/projects", footer ]
