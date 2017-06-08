module Msgs exposing (..)

import Material


type Msg
    = NoOp
    | Mdl (Material.Msg Msg)
