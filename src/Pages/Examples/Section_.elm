module Pages.Examples.Section_ exposing (Model, Msg, page)

import Page
import Request
import Shared
import UI.Projects


page : Shared.Model -> Request.With params -> Page.With Model Msg
page =
    UI.Projects.page


type alias Model =
    UI.Projects.Model


type alias Msg =
    UI.Projects.Msg
