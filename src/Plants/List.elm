module Plants.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (href, class, style)


-- Material
-- import Material

import Material.Table as Table


-- App related

import Msgs exposing (Msg)
import Models exposing (Plant)


view : List Plant -> Html Msg
view plants =
    div []
        [ Table.table []
            [ Table.thead []
                [ Table.tr []
                    [ Table.th [ Table.numeric ] [ text "Id" ]
                    , Table.th [ Table.numeric ] [ text "Name" ]
                    , Table.th [ Table.numeric ] [ text "Description" ]
                    ]
                ]
            , Table.tbody []
                (plants
                    |> List.map
                        (\plant ->
                            Table.tr []
                                [ Table.td [ Table.numeric ] [ text (toString plant.id) ]
                                , Table.td [ Table.numeric ] [ text plant.name ]
                                , Table.td [ Table.numeric ] [ text plant.desc ]
                                ]
                        )
                )
            ]
        ]



--
-- plantRow : Plant -> Html Msg
-- plantRow plant =
--     tr []
--         [ td [] [ text (toString plant.id) ]
--         , td [] [ text plant.name ]
--         , td [] [ text plant.desc ]
--         , td []
--             []
--         ]
