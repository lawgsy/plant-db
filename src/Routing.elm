module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (PlantId, Route(..))
import UrlParser exposing (..)


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map PlantsRoute top
        , map PlantRoute (s "plants" </> int)
        , map PlantsRoute (s "plants")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute


plantsPath : String
plantsPath =
    "#plants"


plantPath : PlantId -> String
plantPath id =
    "#plants/" ++ toString id
