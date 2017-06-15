module Plants.List exposing (..)

import Html exposing (..)


-- Material

import Material.Table as Table
import Material.Options as Options


-- App related

import Msgs exposing (Msg)
import Models exposing (Plant)
import RemoteData exposing (WebData)


view : WebData (List Plant) -> Html Msg
view response =
    div [] [ showData response ]


showData : WebData (List Plant) -> Html Msg
showData response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Failure error ->
            text (toString error)

        RemoteData.Success plants ->
            Table.table []
                -- Table.table [ Options.cs "mx-auto" ]
                [ Table.thead []
                    [ Table.tr [ Options.cs "max-width-1" ]
                        -- [ Table.th [ Table.numeric ] [ text "Id" ]
                        -- ,
                        [ Table.th [ Table.numeric ] [ text "Name" ]
                        , Table.th [ Table.numeric ] [ text "Description" ]
                        ]
                    ]
                , Table.tbody [] (List.map plantRow plants)
                ]


plantRow : Plant -> Html Msg
plantRow plant =
    Table.tr []
        -- [ Table.td [ Table.numeric ] [ text (toString plant.id) ]
        [ Table.td [ Table.numeric ] [ text plant.name ]
        , Table.td [ Table.numeric ] [ text plant.desc ]
        ]
