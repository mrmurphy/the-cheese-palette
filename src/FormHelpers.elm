module FormHelpers (..) where

import Html exposing (..)
import Html.Attributes exposing (type', class, value)
import Html.Events exposing (on, targetValue)
import Signal
import String


boundInput : String -> Signal.Address a -> String -> (String -> a) -> Html
boundInput inputType address val setter =
    input
        [ type' inputType
        , class "form-control"
        , on "input" targetValue (Signal.message address << setter)
        , value val
        ]
        []


textInput : Signal.Address a -> String -> (String -> a) -> Html
textInput =
    boundInput "text"


numberInput : Signal.Address a -> Int -> (Int -> a) -> Html
numberInput address value setter =
    boundInput "number" address (toString value) (setter << (Result.withDefault 0 << String.toInt))


passwordInput : Signal.Address a -> String -> (String -> a) -> Html
passwordInput =
    boundInput "password"
