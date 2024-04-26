module Route exposing (Route(..), parseUrl, pushUrl)

import Browser.Navigation as Nav
import Url exposing (Url)
import Url.Parser exposing (..)


type Route
    = NotFound
    | Home
    | Projects
    | Project String


parseUrl : Url -> Route
parseUrl url =
    case parse matchRoute url of
        Just route ->
            route

        Nothing ->
            Home


matchRoute : Parser (Route -> a) a
matchRoute =
    oneOf
        [ map Home top
        , map Projects (s "projects")
        , map Project (s "projects" </> string)
        ]


pushUrl : Route -> Nav.Key -> Cmd msg
pushUrl route navKey =
    routeToString route
        |> Nav.pushUrl navKey


routeToString : Route -> String
routeToString route =
    case route of
        NotFound ->
            "/not-found"

        Home ->
            "/"

        Projects ->
            "/projects"

        Project projectId ->
            "/projects/" ++ projectId
