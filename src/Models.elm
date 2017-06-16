module Models exposing (..)

-- Material

import Material
import Material.Table as Table


-- App related

import RemoteData exposing (WebData)


-- type alias Mdl =
--   Material.Model


type alias Model =
    { mdl :
        Material.Model
        -- , plants : List Plant
    , data : WebData Data
    , tableOrder : Maybe Table.Order
    , route : Route
    }


initialModel : Route -> Model
initialModel route =
    { mdl = Material.model
    , data =
        RemoteData.Loading
    , tableOrder = Just Table.Ascending
    , route = route
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


type Route
    = PlantsRoute
    | PlantRoute PlantId
    | NotFoundRoute
