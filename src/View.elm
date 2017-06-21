module View exposing (..)

import Html exposing (Html, h1, text, div)
import Html.Attributes exposing (style, class)
import Msgs exposing (Msg)
import Models exposing (Model, PlantId)
import Plants.List
import Plants.Show
import RemoteData


-- Material
-- import Material

import Material.Layout as Layout
import Material.Textfield as Textfield
import Material.Options as Options
import Html.Events exposing (onInput)


-- import Material.Icon as Icon


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    -- div []
    --     [ page model ]
    Layout.render Msgs.Mdl
        model.mdl
        [ Layout.fixedHeader
        , Layout.waterfall False
        ]
        { header =
            [ Layout.row
                [ Options.css "transition" "height 333ms ease-in-out 0s"
                ]
                [ Layout.link
                    [ Layout.href "#plants" ]
                    [ Layout.title []
                        [ text "Plant database"
                        ]
                    ]
                , Layout.spacer
                , Layout.navigation []
                    [ Textfield.render Msgs.Mdl
                        [ 7 ]
                        model.mdl
                        [ Textfield.label "Filter plants..."
                        , Textfield.floatingLabel
                        , Textfield.expandable "id-of-expandable-1"
                        , Textfield.expandableIcon "search"
                        , Textfield.value model.keyword
                        , Options.onInput Msgs.UpdateKeyword
                        , Options.cs "ml1 pt3"
                        ]
                        []
                    ]
                ]
            ]
            -- [ div [ class "align-self flex-end", Html.css "height" "192px" ]
            --     [ text "Plant database"
            --     , Textfield.render Msgs.Mdl
            --         [ 7 ]
            --         model.mdl
            --         [ Textfield.label "Search for a plant..."
            --         , Textfield.floatingLabel
            --         , Textfield.expandable "id-of-expandable-1"
            --         , Textfield.expandableIcon "search"
            --         , Options.cs "ml4"
            --         ]
            --         []
            --     ]
            -- ]
        , drawer =
            [ Layout.title [] [ text "Navigation" ]
            , Layout.navigation
                []
                [ Layout.link
                    [ Layout.href "#plants" ]
                    [ Html.span [] [ text "Home" ] ]
                , Layout.link
                    [ Layout.href "https://en.wikipedia.org/" ]
                    [ Html.span [] [ text "Wikipedia" ] ]
                ]
            ]
        , tabs = ( [], [] )
        , main = [ viewBody model ]
        }


viewBody : Model -> Html Msg
viewBody model =
    div [ class "p3" ]
        [ case model.route of
            Models.PlantsRoute ->
                -- (Plants.List.view model.data model.tableOrder model.keyword model.mdl)
                (Plants.List.view model)

            Models.PlantRoute id ->
                plantShowPage model id

            Models.NotFoundRoute ->
                notFoundView
        ]


plantShowPage : Model -> PlantId -> Html Msg
plantShowPage model plantId =
    case model.data of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading ..."

        RemoteData.Success data ->
            let
                maybePlant =
                    data.plants
                        |> List.filter (\plant -> plant.id == plantId)
                        |> List.head
            in
                case maybePlant of
                    Just plant ->
                        Plants.Show.view model plant

                    Nothing ->
                        notFoundView

        RemoteData.Failure err ->
            text (toString err)


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found"
        ]
