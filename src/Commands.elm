module Commands exposing (..)

-- App related

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required, optional)
import Msgs exposing (Msg)
import Models exposing (PlantId, Plant, Data, ImageObject)
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
        |> required "img" imageDecoder


imageDecoder : Decode.Decoder ImageObject
imageDecoder =
    decode ImageObject
        |> required "url" Decode.string
        |> required "link" Decode.string
        |> required "author" Decode.string
        |> required "license" Decode.string
