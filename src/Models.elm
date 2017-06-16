module Models exposing (..)

-- Material

import Material


-- App related

import RemoteData exposing (WebData)


type alias Model =
    { mdl :
        Material.Model
        -- , plants : List Plant
    , plants : WebData (List Plant)
    , runtimeError : Maybe String
    }


initialModel : Model
initialModel =
    { mdl = Material.model
    , plants =
        RemoteData.Loading
        -- [ { id = 1, name = "Basil", desc = "A green plant." }
        -- , { id = 2, name = "Thyme", desc = "Another green plant." }
        -- ]
    , runtimeError = Nothing
    }


type alias PlantId =
    Int


type alias Plant =
    { id : PlantId
    , name : String
    , desc : String
    }
