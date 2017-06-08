module Update exposing (..)

import Msgs exposing (Msg(..))
import Models exposing (Model)


-- Material

import Material


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Mdl msg_ ->
            Material.update Mdl msg_ model
