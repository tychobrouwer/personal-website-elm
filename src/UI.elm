module UI exposing
    ( Html, none
    , h1, h2, h3, h4, h5, h6
    , link
    , logo, icons, iconLink
    , hero, htmlIf, pageTitle
    )

{-|

@docs Html, none, el, row, col
@docs h1, h2, h3, h4, h5, h6, markdown
@docs pad, padX, padY, align
@docs link
@docs logo, icons, iconLink

-}

-- import Markdown.Html
-- import Url exposing (Url)
-- import View exposing (View)

import Html
import Html.Attributes as Attr
import Svg exposing (Svg, path, svg)
import Svg.Attributes as SvgAttr


type alias Html msg =
    Html.Html msg


none : Html msg
none =
    Html.text ""


link : { text : String, url : String } -> Html msg
link options =
    link_
        { destination = options.url
        , title = Nothing
        }
        [ Html.text options.text
        ]


link_ : { destination : String, title : Maybe String } -> List (Html msg) -> Html msg
link_ options =
    Html.a
        ([ Attr.class "link", Attr.href options.destination ]
            ++ (if String.startsWith "http" options.destination then
                    [ Attr.target "_blank"
                    ]

                else
                    []
               )
        )



-- TYPOGRAPHY


h1 : String -> Html msg
h1 str =
    Html.h1 [ Attr.class "h1" ] [ Html.text str ]


h2 : String -> Html msg
h2 str =
    Html.h2 [ Attr.class "h2" ] [ Html.text str ]


h3 : String -> Html msg
h3 str =
    Html.h3 [ Attr.class "h3" ] [ Html.text str ]


h4 : String -> Html msg
h4 str =
    Html.h4 [ Attr.class "h4" ] [ Html.text str ]


h5 : String -> Html msg
h5 str =
    Html.h5 [ Attr.class "h5" ] [ Html.text str ]


h6 : String -> Html msg
h6 str =
    Html.h6 [ Attr.class "h6" ] [ Html.text str ]



-- HERO


hero : { title : String, description : List String } -> Html msg
hero options =
    Html.div [ Attr.class "hero" ]
        [ Html.div [ Attr.class "hero__logo" ]
            [ h1 options.title
            , Html.div [ Attr.class "text-500" ]
                (List.map (\text -> Html.h2 [ Attr.class "h5" ] [ Html.text text ]) options.description)
            ]
        ]



-- PAGE TITLE


pageTitle : { title : String } -> Html msg
pageTitle options =
    Html.div [ Attr.class "page-title" ]
        [ Html.div [ Attr.class "hero__logo" ]
            [ h1 options.title ]
        ]



-- LOGO


logo : Html msg
logo =
    Html.div [ Attr.class "logo__text" ] [ Html.text "Tycho" ]



-- ICONS


icons :
    { github : Svg msg
    , reddit : Svg msg
    , email : Svg msg
    , linkedin : Svg msg
    , left : Svg msg
    , right : Svg msg
    , down : Svg msg
    }
icons =
    { github =
        svg [ SvgAttr.viewBox "0 0 496 512", SvgAttr.class "github" ]
            [ path [ SvgAttr.d "M165.9 397.4c0 2-2.3 3.6-5.2 3.6-3.3.3-5.6-1.3-5.6-3.6 0-2 2.3-3.6 5.2-3.6 3-.3 5.6 1.3 5.6 3.6zm-31.1-4.5c-.7 2 1.3 4.3 4.3 4.9 2.6 1 5.6 0 6.2-2s-1.3-4.3-4.3-5.2c-2.6-.7-5.5.3-6.2 2.3zm44.2-1.7c-2.9.7-4.9 2.6-4.6 4.9.3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.9zM244.8 8C106.1 8 0 113.3 0 252c0 110.9 69.8 205.8 169.5 239.2 12.8 2.3 17.3-5.6 17.3-12.1 0-6.2-.3-40.4-.3-61.4 0 0-70 15-84.7-29.8 0 0-11.4-29.1-27.8-36.6 0 0-22.9-15.7 1.6-15.4 0 0 24.9 2 38.6 25.8 21.9 38.6 58.6 27.5 72.9 20.9 2.3-16 8.8-27.1 16-33.7-55.9-6.2-112.3-14.3-112.3-110.5 0-27.5 7.6-41.3 23.6-58.9-2.6-6.5-11.1-33.3 2.6-67.9 20.9-6.5 69 27 69 27 20-5.6 41.5-8.5 62.8-8.5s42.8 2.9 62.8 8.5c0 0 48.1-33.6 69-27 13.7 34.7 5.2 61.4 2.6 67.9 16 17.7 25.8 31.5 25.8 58.9 0 96.5-58.9 104.2-114.8 110.5 9.2 7.9 17 22.9 17 46.4 0 33.7-.3 75.4-.3 83.6 0 6.5 4.6 14.4 17.3 12.1C428.2 457.8 496 362.9 496 252 496 113.3 383.5 8 244.8 8zM97.2 352.9c-1.3 1-1 3.3.7 5.2 1.6 1.6 3.9 2.3 5.2 1 1.3-1 1-3.3-.7-5.2-1.6-1.6-3.9-2.3-5.2-1zm-10.8-8.1c-.7 1.3.3 2.9 2.3 3.9 1.6 1 3.6.7 4.3-.7.7-1.3-.3-2.9-2.3-3.9-2-.6-3.6-.3-4.3.7zm32.4 35.6c-1.6 1.3-1 4.3 1.3 6.2 2.3 2.3 5.2 2.6 6.5 1 1.3-1.3.7-4.3-1.3-6.2-2.2-2.3-5.2-2.6-6.5-1zm-11.4-14.7c-1.6 1-1.6 3.6 0 5.9 1.6 2.3 4.3 3.3 5.6 2.3 1.6-1.3 1.6-3.9 0-6.2-1.4-2.3-4-3.3-5.6-2z" ] []
            ]
    , reddit =
        svg [ SvgAttr.viewBox "0 0 512 512", SvgAttr.class "reddit" ]
            [ path [ SvgAttr.d "M201.5 305.5c-13.8 0-24.9-11.1-24.9-24.6 0-13.8 11.1-24.9 24.9-24.9 13.6 0 24.6 11.1 24.6 24.9 0 13.6-11.1 24.6-24.6 24.6zM504 256c0 137-111 248-248 248S8 393 8 256 119 8 256 8s248 111 248 248zm-132.3-41.2c-9.4 0-17.7 3.9-23.8 10-22.4-15.5-52.6-25.5-86.1-26.6l17.4-78.3 55.4 12.5c0 13.6 11.1 24.6 24.6 24.6 13.8 0 24.9-11.3 24.9-24.9s-11.1-24.9-24.9-24.9c-9.7 0-18 5.8-22.1 13.8l-61.2-13.6c-3-.8-6.1 1.4-6.9 4.4l-19.1 86.4c-33.2 1.4-63.1 11.3-85.5 26.8-6.1-6.4-14.7-10.2-24.1-10.2-34.9 0-46.3 46.9-14.4 62.8-1.1 5-1.7 10.2-1.7 15.5 0 52.6 59.2 95.2 132 95.2 73.1 0 132.3-42.6 132.3-95.2 0-5.3-.6-10.8-1.9-15.8 31.3-16 19.8-62.5-14.9-62.5zM302.8 331c-18.2 18.2-76.1 17.9-93.6 0-2.2-2.2-6.1-2.2-8.3 0-2.5 2.5-2.5 6.4 0 8.6 22.8 22.8 87.3 22.8 110.2 0 2.5-2.2 2.5-6.1 0-8.6-2.2-2.2-6.1-2.2-8.3 0zm7.7-75c-13.6 0-24.6 11.1-24.6 24.9 0 13.6 11.1 24.6 24.6 24.6 13.8 0 24.9-11.1 24.9-24.6 0-13.8-11-24.9-24.9-24.9z" ] []
            ]
    , email =
        svg [ SvgAttr.viewBox "0 0 512 512", SvgAttr.class "email" ]
            [ path [ SvgAttr.d "M498.1 5.6c10.1 7 15.4 19.1 13.5 31.2l-64 416c-1.5 9.7-7.4 18.2-16 23s-18.9 5.4-28 1.6L284 427.7l-68.5 74.1c-8.9 9.7-22.9 12.9-35.2 8.1S160 493.2 160 480V396.4c0-4 1.5-7.8 4.2-10.7L331.8 202.8c5.8-6.3 5.6-16-.4-22s-15.7-6.4-22-.7L106 360.8 17.7 316.6C7.1 311.3 .3 300.7 0 288.9s5.9-22.8 16.1-28.7l448-256c10.7-6.1 23.9-5.5 34 1.4z" ] []
            ]
    , linkedin =
        svg [ SvgAttr.viewBox "0 0 448 512", SvgAttr.class "linkedin" ]
            [ path [ SvgAttr.d "M416 32H31.9C14.3 32 0 46.5 0 64.3v383.4C0 465.5 14.3 480 31.9 480H416c17.6 0 32-14.5 32-32.3V64.3c0-17.8-14.4-32.3-32-32.3zM135.4 416H69V202.2h66.5V416zm-33.2-243c-21.3 0-38.5-17.3-38.5-38.5S80.9 96 102.2 96c21.2 0 38.5 17.3 38.5 38.5 0 21.3-17.2 38.5-38.5 38.5zm282.1 243h-66.4V312c0-24.8-.5-56.7-34.5-56.7-34.6 0-39.9 27-39.9 54.9V416h-66.4V202.2h63.7v29.2h.9c8.9-16.8 30.6-34.5 62.9-34.5 67.2 0 79.7 44.3 79.7 101.9V416z" ] [] ]
    , left =
        svg [ SvgAttr.viewBox "0 0 320 512", SvgAttr.class "left" ]
            [ path [ SvgAttr.d "M9.4 233.4c-12.5 12.5-12.5 32.8 0 45.3l192 192c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3L77.3 256 246.6 86.6c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0l-192 192z" ] [] ]
    , right =
        svg [ SvgAttr.viewBox "0 0 320 512", SvgAttr.class "right" ]
            [ path [ SvgAttr.d "M310.6 233.4c12.5 12.5 12.5 32.8 0 45.3l-192 192c-12.5 12.5-32.8 12.5-45.3 0s-12.5-32.8 0-45.3L242.7 256 73.4 86.6c-12.5-12.5-12.5-32.8 0-45.3s32.8-12.5 45.3 0l192 192z" ] [] ]
    , down =
        svg [ SvgAttr.viewBox "0 0 512 512", SvgAttr.class "right" ] [ path [ SvgAttr.d "M233.4 406.6c12.5 12.5 32.8 12.5 45.3 0l192-192c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L256 338.7 86.6 169.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3l192 192z" ] [] ]
    }


iconLink : { text : String, icon : Svg msg, url : String } -> Html msg
iconLink options =
    Html.a [ Attr.href options.url, Attr.class "link__icon-container", Attr.target "_blank", Attr.attribute "aria-label" options.text ]
        [ options.icon ]


htmlIf : Html msg -> Bool -> Html msg
htmlIf el cond =
    if cond then
        el

    else
        Html.text ""
