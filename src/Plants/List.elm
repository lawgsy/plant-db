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



-- showData : WebData Data -> Maybe Table.Order -> String -> mdl -> Html Msg
-- showData response order keyword mdl =


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
                div []
                    ([ (case keyword of
                            "" ->
                                text ""

                            x ->
                                span [ class "mdl-typography--headline-color-contrast mx-auto block" ]
                                    [ Button.render Msgs.Mdl
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
                                    , text ("Current filter: " ++ x)
                                    ]
                       )
                     ]
                        ++ [ Table.table [ Options.cs "mx-auto" ]
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
                                    (let
                                        filteredList =
                                            case keyword of
                                                "" ->
                                                    (data.plants
                                                        |> List.sortBy .name
                                                    )

                                                _ ->
                                                    (data.plants
                                                        |> filterPlants keyword
                                                        |> List.sortBy .name
                                                    )
                                     in
                                        (List.map plantRow
                                            (case order of
                                                Just (Table.Descending) ->
                                                    List.reverse filteredList

                                                _ ->
                                                    filteredList
                                            )
                                        )
                                    )
                                ]
                           ]
                    )


filterPlants : String -> List { a | name : String, synonyms : List String } -> List { a | name : String, synonyms : List String }
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
    --(parseLocation plant.id)(plantPath plant.id)
    -- Options.attribute <| onClick (text "#test")
    Table.tr [ Options.attribute <| onClick (Msgs.NewLocation (plantPath plant.id)), Options.css "cursor" "pointer" ]
        -- [ Table.td [ Table.numeric ] [ text (toString plant.id) ]
        [ Table.td
            [ Options.cs "max-width-4", Options.css "cursor" "pointer", Table.numeric ]
            [ text plant.name ]
        , Table.td
            [ Options.cs "max-width-4", Options.css "cursor" "pointer" ]
            [ text plant.description ]
          -- , Table.td [] [ img [ src ("assets/img/" ++ plant.img), width 200 ] [] ]
        ]
