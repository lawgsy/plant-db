module Commands exposing (..)

-- App related

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Msgs exposing (Msg)
import Models exposing (PlantId, Plant)
import RemoteData


fetchPlants : Cmd Msg
fetchPlants =
    Http.get fetchPlantsUrl plantsDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchPlants


fetchPlantsUrl : String
fetchPlantsUrl =
    "http://localhost:4000/plants"


plantsDecoder : Decode.Decoder (List Plant)
plantsDecoder =
    Decode.list plantDecoder


plantDecoder : Decode.Decoder Plant
plantDecoder =
    decode Plant
        |> required "id" Decode.int
        |> required "name" Decode.string
        |> required "desc" Decode.string
