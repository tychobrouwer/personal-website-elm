module Pages.Projects exposing (Model, Msg, page)

import Gen.Route exposing (Route)
import Html
import Html.Attributes as Attr
import Page
import Request
import Shared
import UI exposing (Html)
import UI.Layout
import View exposing (View)


page : Shared.Model -> Request.With params -> Page.With Model Msg
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
        [ markdownSections
            [ { image = "food_alarm"
              , markdown = """
## Food Alarm App
An app made for a school project using React Native and Expo Go. The app's goal is to decrease food waste, it attempts to achieve this by allowing the user to track the food which is in the users house. It also provides a grocery store list and recipe database linked to the food stored in the inventory.
"""
              , internal = []
              , external =
                    [ ( "GitHub Repo", "https://github.com/TychoBrouwer/Food_App_React_Native" )
                    ]
              }
            , { image = "pokemon_like_game"
              , markdown = """
## Pokémon Inspired Game
A pokemon inspired game written using Electron, TypeScript, and SCSS, more specifically the Pokémon Ruby version. The game is drawn onto an HTML canvas using request animation frame to invoke the repaint. The game has basic fighting mechanics following the original from Pokémon Ruby.
"""
              , internal = []
              , external =
                    [ ( "GitHub Repo", "https://github.com/TychoBrouwer/Pokemon_Game_Electron" )
                    ]
              }
            , { image = "snake_game"
              , markdown = """
## Snake Game
A snake game made using Electron, TypeScript, and SCSS. The game counts the current score and saves the high score. The player can also adjust the game speed and board size. 
"""
              , internal = []
              , external =
                    [ ( "GitHub Repo", "https://github.com/TychoBrouwer/Snake_Game_Electron" )
                    ]
              }
            ]
        ]
    }


markdownSections : List { image : String, markdown : String, internal : List ( String, Route ), external : List ( String, String ) } -> Html msg
markdownSections sections =
    let
        viewSection i { image, markdown, internal, external } =
            Html.section [ Attr.class "projects__section" ]
                [ Html.div [ Attr.class "projects__section-row container row", Attr.classList [ ( "align-right", modBy 2 i == 1 ) ] ]
                    [ Html.div [ Attr.class "col" ]
                        [ UI.markdown { withHeaderLinks = False } markdown
                        , Html.div [ Attr.class "row" ]
                            (List.map
                                (\( label, route ) -> Html.a [ Attr.class "button", Attr.href (Gen.Route.toHref route) ] [ Html.text label ])
                                internal
                                ++ List.map
                                    (\( label, url ) -> Html.a [ Attr.class "button", Attr.href url ] [ Html.text label ])
                                    external
                            )
                        ]
                    , Html.img [ Attr.class "projects__section-image", Attr.src ("/images/projects/" ++ image ++ ".webp") ] []
                    ]
                ]
    in
    Html.main_ [ Attr.class "col" ]
        (List.indexedMap viewSection sections)
