module Admin.Ui.Utils.Message where

import Html exposing (..)
import Html.Attributes exposing (..)


message : String -> Bool -> String -> List Html -> Html
message color showing key children =
  let
    showClass =
      if showing then
        "show"
      else
        "hide"
  in
    div
      [ class ("alert alert-"
                ++ color
                ++ " msg-" ++ showClass)
      , Html.Attributes.key key
      ]
      children
