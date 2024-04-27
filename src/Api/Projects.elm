module Api.Projects exposing (get)

import Api.Data exposing (Data)
import Api.Project exposing (Project, projectDecoder)
import Api.Token
import Env exposing (domain)
import Json.Decode as Json


get :
    { onResponse : Data (List Project) -> msg
    }
    -> Cmd msg
get options =
    Api.Token.get
        { url = domain ++ "/api/projects.json"
        , expect =
            Api.Data.expectJson options.onResponse
                (Json.field "projects" (Json.list projectDecoder))
        }
