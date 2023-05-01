port module Ports exposing (onUrlChange, scrollToElement)


port onUrlChange : () -> Cmd msg


port scrollToElement : String -> Cmd msg
