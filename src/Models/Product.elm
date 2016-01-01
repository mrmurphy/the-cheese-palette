module Models.Product (..) where

import Json.Encode as Encoder exposing (encode)
import Json.Decode as Decoder exposing ((:=))
import Json.Decode.Extra exposing ((|:), withDefault)
import Task exposing (Task, andThen)
import Http exposing (send, defaultSettings, fromJson)
import Effects exposing (Effects)
import Db
import Dict


type alias Product =
    { id : String
    , name : String
    , description : String
    , image : String
    , category : String
    , variant : String
    , price : String
    , sortIndex : Int
    }


emptyProduct : Product
emptyProduct =
    { id = ""
    , name = ""
    , description = ""
    , image = ""
    , category = ""
    , variant = ""
    , price = ""
    , sortIndex = 0
    }


decoder : Decoder.Decoder Product
decoder =
    Decoder.succeed
        Product
        |: ("id" := Decoder.string)
        |: ("name" := Decoder.string)
        |: ("description" := Decoder.string)
        |: ("image" := Decoder.string)
        |: ("category" := Decoder.string)
        |: ("variant" := Decoder.string)
        |: ("price" := Decoder.string)
        |: withDefault 0 ("sortIndex" := Decoder.int)


encoder : Product -> Encoder.Value
encoder p =
    Encoder.object
        [ ( "id", (Encoder.string p.id) )
        , ( "name", (Encoder.string p.name) )
        , ( "description", (Encoder.string p.description) )
        , ( "image", (Encoder.string p.image) )
        , ( "category", (Encoder.string p.category) )
        , ( "variant", (Encoder.string p.variant) )
        , ( "price", (Encoder.string p.price) )
        , ( "sortIndex", (Encoder.int p.sortIndex) )
        ]


encodeProduct : Product -> String
encodeProduct p =
    encode 2 (encoder p)


sort : List Product -> List Product
sort products =
    List.sortWith
        (\a b ->
            if a.category /= b.category then
                compare a.category b.category
            else if a.sortIndex /= b.sortIndex then
                compare a.sortIndex b.sortIndex
            else if a.variant /= b.variant then
                compare a.variant b.variant
            else
                compare a.name b.name
        )
        products


save : String -> Product -> Task Http.Error Product
save token prod =
    send
        defaultSettings
        { verb = "PUT"
        , headers = [ ( "Content-Type", "application/json" ) ]
        , url = (Db.productUrl prod.id) ++ "?auth=" ++ token
        , body = Http.string (encodeProduct prod)
        }
        |> fromJson decoder


saveProduct : String -> Product -> (Product -> a) -> (String -> a) -> Effects a
saveProduct token prod successAction failureAction =
    Effects.task
        (Task.toResult (save token prod)
            |> Task.map
                (\result ->
                    case result of
                        Ok saved ->
                            successAction saved

                        Err err ->
                            failureAction (toString err)
                )
        )


newProduct : String -> Product -> (Product -> a) -> (String -> a) -> Effects a
newProduct token prod successAction failureAction =
    Effects.task
        <| ((send
                defaultSettings
                { verb = "POST"
                , headers = [ ( "Content-Type", "application/json" ) ]
                , url = Db.productsUrl ++ "?auth=" ++ token
                , body = Http.string (encodeProduct prod)
                }
                |> fromJson ("name" := Decoder.string)
            )
                `andThen` (\newId -> save token { prod | id = newId })
                |> Task.toResult
                |> Task.map
                    (\result ->
                        case result of
                            Ok saved ->
                                successAction saved

                            Err err ->
                                failureAction (toString err)
                    )
           )


getAllProducts : (List Product -> a) -> (String -> a) -> Effects a
getAllProducts successAction failureAction =
    Http.get (Decoder.dict decoder) Db.productsUrl
        |> Task.toResult
        |> Task.map
            (\result ->
                case result of
                    Ok prods ->
                        successAction (Dict.values prods)

                    Err err ->
                        failureAction (toString err)
            )
        |> Effects.task
