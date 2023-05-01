module Components.Footer exposing (footer)

import Html exposing (Html)
import Html.Attributes as Attr


footer : Html msg
footer =
    Html.div [ Attr.class "footer__zone" ]
        [ Html.footer [ Attr.class "footer" ]
            [ Html.div [ Attr.class "row spread container" ]
                [ Html.a [ Attr.href "https://github.com/TychoBrouwer/personal_website", Attr.target "_blank", Attr.class "link hidden-mobile" ] [ Html.text "Site source code" ]
                , Html.p [ Attr.class "p" ] [ Html.text "Tycho Brouwer" ]
                ]
            ]
        ]
