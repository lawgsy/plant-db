module Plants.List exposing (..)

import Html exposing (..)


-- Material

import Material.Table as Table
import Material.Progress as Loading
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
            div []
                [ text "Requesting data"
                , Loading.indeterminate
                ]

        RemoteData.Loading ->
            div []
                [ text "Loading data"
                , Loading.indeterminate
                ]

        RemoteData.Failure error ->
            div []
                [ text "An error occurred:"
                , p [] [ text (toString error) ]
                ]

        RemoteData.Success plants ->
            Table.table []
                -- Table.table [ Options.cs "mx-auto" ]
                [ Table.thead []
                    [ Table.tr []
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
        [ Table.td [ Options.cs "max-width-4", Table.numeric ] [ text plant.name ]
        , Table.td [ Options.cs "max-width-4", Table.numeric ] [ text plant.desc ]
        ]
