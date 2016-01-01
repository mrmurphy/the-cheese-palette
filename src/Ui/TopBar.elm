module Ui.TopBar (..) where

import Html exposing (..)
import Html.Attributes exposing (..)


view : Html
view =
    div
        [ class "navbar navbar-default yamm"
        , id "navbar"
        , attribute "role" "navigation"
        ]
        [ div
            [ class "container" ]
            [ div
                [ class "navbar-header" ]
                [ a
                    [ class "navbar-brand home"
                    , attribute "data-animate-hover" "bounce"
                    , href "#/"
                    ]
                    [ img
                        [ alt "Cheese Palette logo"
                        , class "hidden-xs brandLogoLarge"
                        , src "/img/logo.svg"
                        ]
                        []
                    , img
                        [ alt "Cheese Palette logo", class "visible-xs brandLogoSmall", src "/img/logo.svg" ]
                        []
                    , span
                        [ class "sr-only" ]
                        [ text "Cheese Palette go to homepage" ]
                    ]
                , div
                    [ class "navbar-buttons" ]
                    [ button
                        [ class "navbar-toggle", attribute "data-target" "#navigation", attribute "data-toggle" "collapse", type' "button" ]
                        [ span
                            [ class "sr-only" ]
                            [ text "Toggle navigation" ]
                        , i
                            [ class "fa fa-align-justify" ]
                            []
                        ]
                    ]
                ]
            , div
                [ class "navbar-collapse collapse", id "navigation" ]
                [ ul
                    [ class "nav navbar-nav navbar-left" ]
                    [ li
                        []
                        [ a
                            [ href "#/cheeses" ]
                            [ text "Cheeses" ]
                        ]
                    , li
                        []
                        [ a
                            [ href "#/baskets" ]
                            [ text "Baskets" ]
                        ]
                    , li
                        []
                        [ a
                            [ href "#/platters" ]
                            [ text "Platters" ]
                        ]
                    , li
                        []
                        [ a
                            [ href "#/tastings" ]
                            [ text "Tastings" ]
                        ]
                    ]
                ]
            ]
        ]
