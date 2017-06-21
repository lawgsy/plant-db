module Update exposing (..)

-- Material

import Material
import Material.Table as Table


-- App related

import Msgs exposing (Msg(..))
import Models exposing (Model)
import Routing exposing (parseLocation)


-- import UrlParser exposing (..)

import Navigation exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        -- NoOp ->
        --     ( model, Cmd.none )
        Mdl msg_ ->
            Material.update Mdl msg_ model

        Msgs.OnFetchPlants response ->
            ( { model | data = response }, Cmd.none )

        ReorderTable ->
            ( { model | tableOrder = rotate model.tableOrder }, Cmd.none )

        Msgs.OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )

        Msgs.NewLocation url ->
            ( model
            , Navigation.newUrl url
            )

        Msgs.UpdateKeyword query ->
            ( { model | keyword = query }, Cmd.none )


rotate : Maybe Table.Order -> Maybe Table.Order
rotate order =
    case order of
        Just (Table.Ascending) ->
            Just Table.Descending

        Just (Table.Descending) ->
            Just Table.Ascending

        Nothing ->
            Just Table.Ascending
