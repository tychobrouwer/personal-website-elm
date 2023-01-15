module Pages.AboutMe exposing (Model, Msg, page)

import Html
import Html.Attributes as Attr
import Page
import Request
import Shared
import UI exposing (Html)
import UI.Projects
import View exposing (View)


page : Shared.Model -> Request.With params -> Page.With Model Msg
page =
    UI.Projects.page


type alias Model =
    UI.Projects.Model


type alias Msg =
    UI.Projects.Msg


view : View Msg
view =
    { title = "Tycho brouwer"
    , body =
        [ Html.div [ Attr.class "container" ]
            [ Html.text "hello" ]
        ]
    }
