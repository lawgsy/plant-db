module Msgs exposing (..)

-- Material

import Material


-- App related

import Models exposing (Plant)
import RemoteData exposing (WebData)


type Msg
    = Mdl (Material.Msg Msg)
    | OnFetchPlants (WebData (List Plant))
