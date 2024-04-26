module Main exposing (main)

import Browser exposing (Document, UrlRequest)
import Browser.Navigation as Nav
import Html exposing (..)
import Page.Home as Home
import Page.Project as Project
import Page.Projects as Projects
import Route exposing (Route)
import Url exposing (Url)


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        , onUrlRequest = LinkClicked
        , onUrlChange = UrlChanged
        }


type alias Model =
    { route : Route
    , page : Page
    , navKey : Nav.Key
    }


type Page
    = NotFoundPage
    | Home Home.Model
    | Projects Projects.Model
    | Project Project.Model


type Msg
    = HomeMsg Home.Msg
    | LinkClicked UrlRequest
    | UrlChanged Url
    | ProjectsMsg Projects.Msg
    | ProjectMsg Project.Msg


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url navKey =
    let
        model =
            { route = Route.parseUrl url
            , page = NotFoundPage
            , navKey = navKey
            }
    in
    initCurrentPage ( model, Cmd.none )


initCurrentPage : ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
initCurrentPage ( model, existingCmds ) =
    let
        ( currentPage, mappedPageCmds ) =
            case model.route of
                Route.NotFound ->
                    ( NotFoundPage, Cmd.none )

                Route.Home ->
                    let
                        ( pageModel, pageCmds ) =
                            Home.init model.navKey
                    in
                    ( Home pageModel, Cmd.map HomeMsg pageCmds )

                Route.Projects ->
                    let
                        ( pageModel, pageCmds ) =
                            Projects.init model.navKey
                    in
                    ( Projects pageModel, Cmd.map ProjectsMsg pageCmds )

                Route.Project projectId ->
                    let
                        ( pageModel, pageCmd ) =
                            Project.init projectId model.navKey
                    in
                    ( Project pageModel, Cmd.map ProjectMsg pageCmd )
    in
    ( { model | page = currentPage }
    , Cmd.batch [ existingCmds, mappedPageCmds ]
    )


view : Model -> Document Msg
view model =
    { title = "Portfolio"
    , body = [ currentView model ]
    }


currentView : Model -> Html Msg
currentView model =
    case model.page of
        NotFoundPage ->
            notFoundView

        Home pageModel ->
            Home.view pageModel
                |> Html.map HomeMsg

        Projects pageModel ->
            Projects.view pageModel
                |> Html.map ProjectsMsg

        Project pageModel ->
            Project.view pageModel
                |> Html.map ProjectMsg


notFoundView : Html msg
notFoundView =
    h3 [] [ text "Oops! The page you requested was not found!" ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model.page ) of
        ( HomeMsg subMsg, Home pageModel ) ->
            let
                ( updatedPageModel, updatedCmd ) =
                    Home.update subMsg pageModel
            in
            ( { model | page = Home updatedPageModel }
            , Cmd.map HomeMsg updatedCmd
            )

        ( LinkClicked urlRequest, _ ) ->
            case urlRequest of
                Browser.Internal url ->
                    ( model
                    , Nav.pushUrl model.navKey (Url.toString url)
                    )

                Browser.External url ->
                    ( model
                    , Nav.load url
                    )

        ( UrlChanged url, _ ) ->
            let
                newRoute =
                    Route.parseUrl url
            in
            ( { model | route = newRoute }, Cmd.none )
                |> initCurrentPage

        ( ProjectsMsg subMsg, Projects pageModel ) ->
            let
                ( updatedPageModel, updatedCmd ) =
                    Projects.update subMsg pageModel
            in
            ( { model | page = Projects updatedPageModel }
            , Cmd.map ProjectsMsg updatedCmd
            )

        ( ProjectMsg subMsg, Project pageModel ) ->
            let
                ( updatedPageModel, updatedCmd ) =
                    Project.update subMsg pageModel
            in
            ( { model | page = Project updatedPageModel }
            , Cmd.map ProjectMsg updatedCmd
            )

        ( _, _ ) ->
            ( model, Cmd.none )
