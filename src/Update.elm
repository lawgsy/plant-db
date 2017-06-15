module Update exposing (..)

-- Material

import Material


-- App related

import Msgs exposing (Msg(..))
import Models exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        -- NoOp ->
        --     ( model, Cmd.none )
        Mdl msg_ ->
            Material.update Mdl msg_ model

        Msgs.OnFetchPlants response ->
            ( { model | plants = response }, Cmd.none )
