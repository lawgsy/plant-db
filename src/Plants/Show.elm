module Plants.Show exposing (..)

-- Material
-- import Material

import Material.Button as Button
import Material.Options as Options
import Material.Table as Table
import Material.Card as Card
import Material.Typography as Typo
import Material.Color as Color


-- App related

import Html exposing (..)
import Html.Attributes exposing (class, value, href, src, width, height, class)
import Msgs exposing (Msg)
import Models exposing (Model, Plant, ImageObject)
import Routing exposing (plantsPath)
import List exposing (map, foldr)
import Markdown


view : Model -> Plant -> Html Msg
view model plant =
    div []
        [ display model plant
        ]


display : Model -> Plant -> Html Msg
display model plant =
    div [ class "m3" ]
        -- [ h1 [ class "center" ] [ text plant.name ]
        [ showTitle plant
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


showTitle : Plant -> Html Msg
showTitle plant =
    Card.view
        [ Options.css "width" "100%"
        , Options.css "height" "256px"
        , Options.css "background" ("url(" ++ plant.img.url ++ ") center / cover")
        , Options.cs "mx-auto mt0 pt0"
        , Options.css "display" "flex"
        , Options.css "justify-content" "space-between"
        ]
        [ Card.text [ Card.expand ] []
          -- Filler
        , Card.text
            [ Options.css "background" "rgba(0, 0, 0, 0.5)", Options.css "width" "100%" ]
            -- Non-gradient scrim
            [ Options.span
                [ Color.text Color.white, Typo.title, Typo.contrast 1.0, Options.cs "fit" ]
                [ text plant.name ]
            , Options.span
                [ Color.text Color.white, Typo.subhead, Typo.contrast 1.0, Options.css "float" "right", Typo.uppercase, Typo.right ]
                [ text plant.name_scientific ]
            ]
        ]


infoTable : Plant -> Html Msg
infoTable plant =
    let
        table_data =
            [ ( "Family", plant.family )
            , ( "Description", plant.description )
            , ( "Image information"
              , (plant.img.link
                    ++ " by "
                    ++ plant.img.author
                    ++ " is licensed under "
                    ++ plant.img.license
                )
              )
            , ( "Synonyms", String.join ", " (List.sort plant.synonyms) )
              -- , ( "Image", plant.img )
            ]
    in
        Table.table [ Options.cs "mx-auto fit", Options.css "width" "100%" ]
            [ Table.tbody []
                (-- [ Table.tr []
                 --     [ Table.td [ Options.cs "max-width-4", Options.attribute <| (Html.Attributes.colspan 2) ] [ Html.img [ src plant.img.url, class "fit max-width-1 block mx-auto" ] [] ]
                 --     ]
                 --  ]
                 --     ++ ()
                 List.map showRow table_data
                )
            ]


showRow : ( String, String ) -> Html Msg
showRow ( txt, content ) =
    Table.tr []
        [ Table.td [] [ text txt ]
        , Table.td [ Options.cs "fit" ] [ Markdown.toHtml [] content ]
        ]
