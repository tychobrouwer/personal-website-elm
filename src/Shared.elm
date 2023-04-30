module Shared exposing
    ( Flags
    , Model
    , Msg
    , init
    , subscriptions
    , update
    )

-- import Browser.Navigation exposing (Key)
-- import Dict exposing (Dict)
-- import Url exposing (Url)

import Json.Decode as Json
import Request exposing (Request)


type alias Flags =
    Json.Value


type alias Model =
    {}



-- type alias Token =
--     ()


type Msg
    = NoOp



-- INIT


init : Request -> Flags -> ( Model, Cmd Msg )
init _ flags =
    ( {}
    , Cmd.none
    )



-- UPDATE


update : Request -> Msg -> Model -> ( Model, Cmd Msg )
update request msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Request -> Model -> Sub Msg
subscriptions request model =
    Sub.none
