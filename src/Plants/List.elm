module Plants.List exposing (..)

import Html exposing (..)


-- Material

import Material.Table as Table
import Material.Options as Options


-- App related

import Msgs exposing (Msg)
import Models exposing (Plant)


view : List Plant -> Html Msg
view plants =
    div []
        [ Table.table [ Options.cs "mx-auto" ]
            [ Table.thead []
                [ Table.tr []
                    [ Table.th [ Table.numeric ] [ text "Id" ]
                    , Table.th [ Table.numeric ] [ text "Name" ]
                    , Table.th [ Table.numeric ] [ text "Description" ]
                    ]
                ]
            , Table.tbody [] (List.map plantRow plants)
            ]
        ]


plantRow : Plant -> Html Msg
plantRow plant =
    Table.tr []
        [ Table.td [ Table.numeric ] [ text (toString plant.id) ]
        , Table.td [ Table.numeric ] [ text plant.name ]
        , Table.td [ Table.numeric ] [ text plant.desc ]
        ]
