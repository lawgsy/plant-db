module Commands exposing (..)

-- App related

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Msgs exposing (Msg)
import Models exposing (PlantId, Plant, Data)
import RemoteData


-- import String


fetchPlants : Cmd Msg
fetchPlants =
    Http.get fetchPlantsUrl plantsDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchPlants


fetchPlantsUrl : String
fetchPlantsUrl =
    "db.json"



-- "http://localhost:4000/plants"


plantsDecoder : Decode.Decoder Data
plantsDecoder =
    decode Data
        |> required "plants" (Decode.list plantDecoder)



-- Decode.map (required "plants" (Decode.list plantDecoder))
-- (Decode.list plantDecoder)


plantDecoder : Decode.Decoder Plant
plantDecoder =
    decode Plant
        |> required "id" Decode.int
        |> required "name" Decode.string
        |> required "name_scientific" Decode.string
        |> required "synonyms" (Decode.list Decode.string)
        |> required "family" Decode.string
        |> required "description" Decode.string
        |> required "uses_culinary" (Decode.list Decode.string)
        |> required "uses_medical" (Decode.list Decode.string)
        |> required "warnings" (Decode.list Decode.string)
        |> required "img" Decode.string
