module Plants.List exposing (..)

import Html exposing (..)


-- import Html.Attributes exposing (src, width, height)

import Msgs exposing (Msg)


-- Material

import Material.Table as Table
import Material.Progress as Loading
import Material.Options as Options exposing (nop)


-- App related

import Msgs exposing (Msg)
import Models exposing (Plant, Data)
import RemoteData exposing (WebData)


view : WebData Data -> Maybe Table.Order -> Html Msg
view response order =
    div [] [ (showData response order) ]


showData : WebData Data -> Maybe Table.Order -> Html Msg
showData response order =
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

        RemoteData.Success data ->
            Table.table [ Options.cs "mx-auto" ]
                -- Table.table [ Options.cs "mx-auto" ]
                [ Table.thead []
                    [ Table.tr []
                        -- [ Table.th [ Table.numeric ] [ text "Id" ]
                        -- ,
                        [ Table.th
                            [ order
                                |> Maybe.map Table.sorted
                                |> Maybe.withDefault nop
                            , Options.onClick Msgs.ReorderTable
                            ]
                            [ text "Name" ]
                          -- [ Table.th [ Table.descending, Options.onClick Msgs.ReorderTable ] [ text "Name" ]
                          -- [ Table.th [ Table.onClick Reorder ] [ text "Name" ]
                          -- , Table.descending
                        , Table.th [] [ text "Description" ]
                          -- , Table.th [] [ text "Image" ]
                        ]
                    ]
                , Table.tbody []
                    (List.map plantRow
                        (case order of
                            Just (Table.Descending) ->
                                List.reverse (data.plants |> List.sortBy .name)

                            _ ->
                                (data.plants |> List.sortBy .name)
                        )
                    )
                ]


plantRow : Plant -> Html Msg
plantRow plant =
    Table.tr []
        -- [ Table.td [ Table.numeric ] [ text (toString plant.id) ]
        [ Table.td [ Options.cs "max-width-4", Table.numeric ] [ text plant.name ]
        , Table.td [ Options.cs "max-width-4" ] [ text plant.desc ]
          -- , Table.td [] [ img [ src ("assets/img/" ++ plant.img), width 200 ] [] ]
        ]
