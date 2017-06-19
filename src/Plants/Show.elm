module Plants.Show exposing (..)

-- Material
-- import Material

import Material.Button as Button
import Material.Options as Options
import Material.Table as Table


-- App related

import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Msgs exposing (Msg)
import Models exposing (Model, Plant)
import Routing exposing (plantsPath)


view : Model -> Plant -> Html Msg
view model plant =
    div []
        [ display model plant
        ]


display : Model -> Plant -> Html Msg
display model plant =
    div [ class "m3" ]
        [ h1 [] [ text plant.name ]
        , infoTable plant
        , Button.render Msgs.Mdl
            [ 9, 0, 0, 2 ]
            model.mdl
            [ Button.ripple
            , Button.colored
            , Button.raised
            , Button.link plantsPath
            , Options.cs "align-right mt2"
            ]
            [ text "Back" ]
        ]


infoTable : Plant -> Html Msg
infoTable plant =
    Table.table []
        [ Table.tbody []
            [ Table.tr
                []
                [ Table.td [] [ text "Scientific name" ]
                , Table.td [ Table.numeric ] [ text plant.name_scientific ]
                ]
            , Table.tr
                []
                [ Table.td [] [ text "Family" ]
                , Table.td [ Table.numeric ] [ text plant.family ]
                ]
            , Table.tr
                []
                [ Table.td [] [ text "Description" ]
                , Table.td [ Table.numeric ] [ text plant.description ]
                ]
            , Table.tr
                []
                [ Table.td [] [ text "Image" ]
                , Table.td [ Table.numeric ] [ text plant.img ]
                ]
            ]
        ]



-- div
--     [ class "clearfix py1"
--     ]
--     [ div [ class "col col-1" ] [ text "Scientific name" ]
--     , div [ class "col col-11" ]
--         [ span [ class "h2 bold" ] [ text plant.name_scientific ]
--         ]
--     , div [ class "col col-1" ] [ text "Family" ]
--     , div [ class "col col-11" ]
--         [ span [ class "h2 bold" ] [ text plant.family ]
--         ]
--     , div [ class "col col-1" ] [ text "Description" ]
--     , div [ class "col col-11" ]
--         [ span [ class "h2 bold" ] [ text plant.description ]
--         ]
--     , div [ class "col col-1" ] [ text "Image" ]
--     , div [ class "col col-11" ]
--         [ span [ class "h2 bold" ] [ text plant.img ]
--         ]
--     ]
