module ProjectData exposing (projectData)

import Gen.Route exposing (Route)


projectData :
    List
        { image : String
        , markdown : String
        , internal : List ( String, Route )
        , external : List ( String, String )
        }
projectData =
    [ { image = "mail_app"
      , markdown = """
## Mail Client App
A mail client for desktop made using flutter. The goal of this project is to make a client which simply does your mail, with the ability to customize the client by disabling features you do not need. In the current state the client can read rendered HTML emails from one or multiple IMAP servers. The app is not tested for platforms other than Windows at the moment.
"""
      , internal = []
      , external =
            [ ( "GitHub Repo", "https://github.com/TychoBrouwer/Mail_App" )
            ]
      }
    , { image = "food_alarm"
      , markdown = """
## Food Alarm App
An mobile app made for a school project using React Native and Expo Go. The app's goal is to decrease food waste, it attempts to achieve this by allowing the user to track the food which is in the users house. It also provides a grocery store list and recipe database linked to the food stored in the inventory.
"""
      , internal = []
      , external =
            [ ( "GitHub Repo", "https://github.com/TychoBrouwer/Food_App_React_Native" )
            ]
      }
    , { image = "pokemon_like_game"
      , markdown = """
## Pokémon Inspired Game
A Pokémon inspired game written using Electron, TypeScript, and SCSS, more specifically the Pokémon Ruby version. The game is drawn onto an HTML canvas using request animation frame to invoke the repaint. The game has basic fighting mechanics following the original from Pokémon Ruby.
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
