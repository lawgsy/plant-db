module Plants.Show exposing (..)

-- Material
-- import Material

import Material.Button as Button


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
            ]
            [ text "Back" ]
        ]


infoTable : Plant -> Html Msg
infoTable plant =
    div
        [ class "clearfix py1"
        ]
        [ div [ class "col col-1" ] [ text "Description" ]
        , div [ class "col col-11" ]
            [ span [ class "h2 bold" ] [ text plant.desc ]
            ]
        , div [ class "col col-1" ] [ text "Image" ]
        , div [ class "col col-11" ]
            [ span [ class "h2 bold" ] [ text plant.img ]
            ]
        ]
