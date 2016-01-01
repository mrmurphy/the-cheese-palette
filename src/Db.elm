module Db (..) where

import Secrets exposing (apiBase)
import Task exposing (map, mapError, Task)
import Models.User exposing (User)
import ElmFire.Auth exposing (withPassword, authenticate)
import ElmFire exposing (fromUrl)
import Json.Decode as Decode exposing (decodeValue, (:=))
import Json.Encode
import Result exposing (toMaybe)
import Maybe


productsUrl : String
productsUrl =
    apiBase ++ "/products.json"


productUrl : String -> String
productUrl id =
    apiBase ++ "/products/" ++ id ++ ".json"


getEmail : Json.Encode.Value -> String
getEmail val =
    decodeValue ("email" := Decode.string) val
    |> toMaybe |> Maybe.withDefault "Unparseable email"


auth : String -> String -> Task String User
auth email pass =
    let
        loc = fromUrl apiBase
    in
        authenticate loc [] (withPassword email pass)
            |> mapError toString
            |> map
                (\deets ->
                    { username = getEmail deets.specifics
                    , token = deets.token
                    }
                )
