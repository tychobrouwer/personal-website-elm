module Pages.Home_ exposing (Model, Msg, page)

-- import Gen.Route exposing (Route)

import Gen.Params.Home_ exposing (Params)
import Html
import Html.Attributes as Attr
import Page
import Request
import Shared
import UI exposing (Html)
import UI.Layout
import View exposing (View)


page : Shared.Model -> Request.With Params -> Page.With Model Msg
page =
    UI.Layout.pageFullWidth
        { view = view
        }


type alias Model =
    UI.Layout.Model


type alias Msg =
    UI.Layout.Msg


view : View Msg
view =
    { title = "Tycho brouwer"
    , body =
        [ Html.div [ Attr.class "container home__page" ]
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
        ]
    }
