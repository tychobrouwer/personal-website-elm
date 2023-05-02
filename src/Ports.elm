port module Ports exposing (onUrlChange, scroll, scrollToElement)


port onUrlChange : () -> Cmd msg


port scrollToElement : String -> Cmd msg


port scroll : Float -> Cmd msg
