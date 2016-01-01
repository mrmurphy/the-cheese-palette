module Ui.Rotator (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Maybe
import Array
import Time
import Signal exposing (Signal, foldp)


type alias Props =
    { left : String
    , right : String
    }


view : Props -> Html
view props =
    div
        [ class "rotator" ]
        [ div
            [ class "leftHalf" ]
            [ text props.left ]
        , div
            [ class "rightHalf" ]
            [ text props.right ]
        ]


indexToName : List String -> Int -> String
indexToName xs i =
    Maybe.withDefault "bad index"
        <| Array.get i
        <| Array.fromList xs


changes : List String -> Signal String
changes orig =
    foldp
        (\_ idx -> (idx + 1) % (List.length orig))
        0
        (Time.every (Time.second * 3))
        |> Signal.map (indexToName orig)
