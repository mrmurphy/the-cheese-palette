module ViewHelpers where

import Html exposing (..)
import Html.Attributes exposing (class)

inRow : Html -> Html
inRow el =
  div
    [class "row"]
    [ div
      [class "col-sm-12"]
      [el]
    ]

inGrid : Html -> Html
inGrid el =
  div
    [class "container"]
    [el]
