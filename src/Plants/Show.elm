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
import List exposing (map)


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
    let
        table_data =
            [ ( "Scientific name", plant.name_scientific )
            , ( "Family", plant.family )
            , ( "Description", plant.description )
            , ( "Image", plant.img )
            ]
    in
        Table.table []
            [ Table.tbody [] (List.map showRow table_data) ]


showRow : ( String, String ) -> Html Msg
showRow ( txt, content ) =
    Table.tr []
        [ Table.td [] [ text txt ]
        , Table.td [ Options.cs "max-width-4" ] [ text content ]
        ]
