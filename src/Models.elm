module Models exposing (..)

-- Material

import Material


type alias Model =
    { mdl : Material.Model
    , plants : List Plant
    }


initialModel : Model
initialModel =
    { mdl = Material.model
    , plants =
        [ { id = 1, name = "Basil", desc = "A green plant." }
        , { id = 2, name = "Thyme", desc = "Another green plant." }
        ]
    }


type alias PlantId =
    Int


type alias Plant =
    { id : Int
    , name : String
    , desc : String
    }
