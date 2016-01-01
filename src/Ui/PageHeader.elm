module Ui.PageHeader (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import ViewHelpers exposing (inGrid, inRow)


pageHeader : String -> Html -> Html
pageHeader title subtitle =
    div
        []
        [ div [ class "hero" ] []
        , div
            [ class "box" ]
            [ inGrid
                << inRow
                <| div
                    []
                    [ h1
                        []
                        [ text title ]
                    , subtitle
                    ]
            ]
        ]
