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
    , keyword : String
    }


initialModel : Route -> Model
initialModel route =
    { mdl = Material.model
    , data =
        RemoteData.Loading
    , tableOrder = Just Table.Ascending
    , route = route
    , keyword = ""
    }


type alias PlantId =
    Int


type alias ImageObject =
    { url : String
    , copyright : String
    , license : String
    }


type alias Plant =
    { id : PlantId
    , name : String
    , name_scientific : String
    , synonyms : List String
    , family : String
    , description : String
    , uses_culinary : List String
    , uses_medical : List String
    , warnings : List String
    , img : ImageObject
    }


type alias Data =
    { plants : List Plant
    }


type Route
    = PlantsRoute
    | PlantRoute PlantId
    | NotFoundRoute
