module Models exposing (..)

-- Material

import Material
import Material.Table as Table


-- App related

import RemoteData exposing (WebData)


type alias Model =
    { mdl :
        Material.Model
        -- , plants : List Plant
    , data : WebData Data
    , tableOrder : Maybe Table.Order
    , runtimeError : Maybe String
    }


initialModel : Model
initialModel =
    { mdl = Material.model
    , data =
        RemoteData.Loading
    , tableOrder = Just Table.Ascending
    , runtimeError = Nothing
    }


type alias PlantId =
    Int


type alias Plant =
    { id : PlantId
    , name : String
    , desc : String
    , img : String
    }


type alias Data =
    { plants : List Plant
    }
