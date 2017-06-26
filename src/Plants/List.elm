module Plants.List exposing (..)

import Html exposing (..)


-- import Html.Attributes exposing (src, width, height)

import Html.Events exposing (onClick)
import Msgs exposing (Msg)


-- Material

import Material.Table as Table
import Material.Progress as Loading
import Material.Options as Options exposing (nop)
import Material.Button as Button


-- App related

import Msgs exposing (Msg)
import Models exposing (Plant, Data, Model)
import RemoteData exposing (WebData)
import Routing exposing (plantPath)
import List exposing (filter)
import Regex
import Html.Attributes exposing (class)


-- import Navigation exposing (load)
-- view : WebData Data -> Maybe Table.Order -> String -> mdl -> Html Msg
-- view response order keyword mdl =
--     div [] [ (showData response order keyword mdl) ]


view : Model -> Html Msg
view model =
    div [] [ showData model ]


showData : Model -> Html Msg
showData model =
    let
        response =
            model.data

        order =
            model.tableOrder

        keyword =
            model.keyword

        mdl =
            model.mdl

        buttonHtml =
            Button.render Msgs.Mdl
                [ 9, 0, 0, 2 ]
                mdl
                [ Button.ripple
                , Button.colored
                , Button.accent
                , Button.raised
                , Button.link Routing.plantsPath
                , Options.cs "align-right mr2 mb1"
                , Options.onClick (Msgs.UpdateKeyword "")
                ]
                [ text "clear filter" ]
    in
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
                let
                    plantList =
                        case order of
                            Just (Table.Descending) ->
                                List.reverse
                                    (filterSort
                                        keyword
                                        data.plants
                                    )

                            _ ->
                                filterSort
                                    keyword
                                    data.plants
                in
                    div []
                        ([ (case keyword of
                                "" ->
                                    text ""

                                x ->
                                    span [ class "mdl-typography--headline-color-contrast mx-auto block" ]
                                        [ buttonHtml
                                        , text ("Current filter: " ++ x)
                                        ]
                           )
                         ]
                            ++ [ Table.table [ Options.cs "mx-auto" ]
                                    [ Table.thead []
                                        [ Table.tr []
                                            [ Table.th
                                                [ order
                                                    |> Maybe.map
                                                        Table.sorted
                                                    |> Maybe.withDefault
                                                        nop
                                                , Options.onClick
                                                    Msgs.ReorderTable
                                                ]
                                                [ text "Name" ]
                                            , Table.th []
                                                [ text "Description"
                                                ]
                                            ]
                                        ]
                                    , Table.tbody []
                                        (List.map plantRow plantList)
                                    ]
                               ]
                        )


filterSort :
    String
    -> List { a | name : String, synonyms : List String }
    -> List { a | name : String, synonyms : List String }
filterSort keyword =
    case keyword of
        "" ->
            (List.sortBy .name)

        _ ->
            (filterPlants keyword) >> (List.sortBy .name)


filterPlants :
    String
    -> List { a | name : String, synonyms : List String }
    -> List { a | name : String, synonyms : List String }
filterPlants keyword =
    let
        pattern =
            Regex.caseInsensitive (Regex.regex keyword)
    in
        List.filter
            (\plant ->
                ((Regex.contains pattern plant.name)
                    || (List.any (Regex.contains pattern)
                            plant.synonyms
                       )
                )
            )



-- (String.contains keyword)


plantRow : Plant -> Html Msg
plantRow plant =
    Table.tr
        [ Options.attribute <|
            onClick (Msgs.NewLocation (plantPath plant.id))
        , Options.css "cursor" "pointer"
        ]
        [ Table.td
            [ Options.cs "max-width-4", Options.css "cursor" "pointer", Table.numeric ]
            [ text plant.name ]
        , Table.td
            [ Options.cs "max-width-4", Options.css "cursor" "pointer" ]
            [ text plant.description ]
        ]
