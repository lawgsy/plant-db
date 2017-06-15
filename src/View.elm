module View exposing (..)

import Html exposing (Html, h1, text, div)
import Html.Attributes exposing (style, class)
import Msgs exposing (Msg)
import Models exposing (Model)
import Plants.List


-- Material

import Material
import Material.Layout as Layout


type alias Mdl =
    Material.Model


view : Model -> Html Msg
view model =
    -- div []
    --     [ page model ]
    Layout.render Msgs.Mdl
        model.mdl
        [ Layout.fixedHeader
        ]
        { header = [ h1 [ class "pl3" ] [ text "Plant database" ] ]
        , drawer = []
        , tabs = ( [], [] )
        , main = [ viewBody model ]
        }


viewBody : Model -> Html Msg
viewBody model =
    div [ class "p3" ] [ Plants.List.view model.plants ]
