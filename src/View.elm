module View exposing (..)

import Html exposing (Html, h1, text, div)
import Html.Attributes exposing (style, class)
import Msgs exposing (Msg)
import Models exposing (Model, PlantId)
import Plants.List
import Plants.Show
import RemoteData


-- Material
-- import Material

import Material.Layout as Layout


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    -- div []
    --     [ page model ]
    Layout.render Msgs.Mdl
        model.mdl
        [ Layout.fixedHeader
        ]
        { header = [ h1 [ class "pl3" ] [ text "Plant database" ] ]
        , drawer = []
        , tabs = ( [], [] )
        , main = [ viewBody model ]
        }


viewBody : Model -> Html Msg
viewBody model =
    div [ class "p3" ]
        [ case model.route of
            Models.PlantsRoute ->
                (Plants.List.view model.data model.tableOrder)

            Models.PlantRoute id ->
                plantShowPage model id

            Models.NotFoundRoute ->
                notFoundView
        ]


plantShowPage : Model -> PlantId -> Html Msg
plantShowPage model plantId =
    case model.data of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading ..."

        RemoteData.Success data ->
            let
                maybePlant =
                    data.plants
                        |> List.filter (\plant -> plant.id == plantId)
                        |> List.head
            in
                case maybePlant of
                    Just plant ->
                        Plants.Show.view model plant

                    Nothing ->
                        notFoundView

        RemoteData.Failure err ->
            text (toString err)


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found"
        ]
