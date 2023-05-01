module Pages.Home_ exposing (Model, Msg, page)

-- import Gen.Route exposing (Route)

import Components.Footer exposing (footer)
import Components.Navbar exposing (navbar)
import Gen.Params.Home_ exposing (Params)
import Html
import Html.Attributes as Attr
import Page
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
    {}


init : Shared.Model -> ( Model, Cmd Msg )
init _ =
    ( {}, Cmd.none )


type Msg
    = NoOp



-- UPDATE


update : Request.With Params -> Msg -> Model -> ( Model, Cmd Msg )
update _ msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Url -> Model -> View Msg
view url _ =
    { title = "Tycho brouwer"
    , body =
        [ navbar url
        , Html.div [ Attr.class "container home__page" ]
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
            ]
        , footer
        ]
    }
