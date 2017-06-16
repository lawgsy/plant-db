module Msgs exposing (..)

-- Material

import Material


-- App related

import Models exposing (Plant, Data)
import RemoteData exposing (WebData)


type Msg
    = Mdl (Material.Msg Msg)
    | OnFetchPlants (WebData Data)
    | ReorderTable
