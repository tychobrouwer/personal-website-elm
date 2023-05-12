module Pages.Home_ exposing (Model, Msg, page)

import Api.Data exposing (Data)
import Api.Project exposing (Project, getProjectName)
import Api.Projects
import Components.Carousel exposing (carousel)
import Components.Footer exposing (footer)
import Components.Navbar exposing (navbar)
import Gen.Params.Home_ exposing (Params)
import Html
import Html.Attributes as Attr
import Html.Events as Events
import Json.Decode as Decode
import Page
import Ports exposing (scroll, scrollToElement)
import Request
import Shared
import UI
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
    , elementId : Int
    }


init : Shared.Model -> ( Model, Cmd Msg )
init _ =
    ( { project = Api.Data.Loading, projectsData = [], elementId = 0 }
    , Api.Projects.get
        { onResponse = LoadedProjects }
    )


type Msg
    = LoadedProjects (Data (List Project))
    | ScrollElementLeft
    | ScrollElementRight
    | Scroll ScrollEvent



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

        ScrollElementRight ->
            ( { model
                | elementId = getNextIndex True model.elementId (List.length model.projectsData)
              }
            , scrollToElement
                (getProjectName
                    (getNextIndex True model.elementId (List.length model.projectsData))
                    model.projectsData
                )
            )

        ScrollElementLeft ->
            ( { model
                | elementId = getNextIndex False model.elementId (List.length model.projectsData)
              }
            , scrollToElement
                (getProjectName
                    (getNextIndex False model.elementId (List.length model.projectsData))
                    model.projectsData
                )
            )

        Scroll scrollData ->
            ( model, scroll scrollData.deltaX )


type alias ScrollEvent =
    { deltaX : Float
    , deltaY : Float
    }


scrollDecoder : Decode.Decoder Msg
scrollDecoder =
    Decode.succeed ScrollEvent
        |> andMap (Decode.field "deltaY" Decode.float)
        |> andMap (Decode.field "deltaX" Decode.float)
        |> Decode.map Scroll


andMap : Decode.Decoder a -> Decode.Decoder (a -> b) -> Decode.Decoder b
andMap =
    Decode.map2 (|>)


getNextIndex : Bool -> Int -> Int -> Int
getNextIndex up index length =
    if up && index == length - 1 then
        0

    else if not up && index == 0 then
        length - 1

    else if up then
        index + 1

    else
        index - 1


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Url -> Model -> View Msg
view url model =
    { title = "Tycho brouwer"
    , body =
        [ navbar url
        , Html.div [ Attr.id "home__page", Attr.class "container home__page" ]
            [ UI.hero
                { title = "Tycho Brouwer"
                , description =
                    [ "A site for showcasing my projects"
                    , "current, finished, and never finished."
                    ]
                }
            , Html.div [ Attr.class "introduction" ]
                [ Html.p [ Attr.class "p" ]
                    [ Html.text "A mechanical engineering student at the Eindhoven University of Technology," ]
                , Html.p [ Attr.class "p" ]
                    [ Html.text "interested in everything software and technology related" ]
                ]
            , Html.div [ Attr.class "carousel__container", Events.on "wheel" scrollDecoder ]
                [ carousel model.projectsData
                , Html.div [ Events.onClick ScrollElementLeft, Attr.class "carousel_arrow left" ] [ UI.icons.left ]
                , Html.div [ Events.onClick ScrollElementRight, Attr.class "carousel_arrow right" ] [ UI.icons.right ]
                ]
            ]
        , footer
        ]
    }
