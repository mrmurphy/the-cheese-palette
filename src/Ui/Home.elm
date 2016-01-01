module Ui.Home (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Ui.Rotator


heroImage : Html
heroImage =
    div
        [ class "hero" ]
        []


type alias Props =
    { rotator : String
    }


rotator props =
    div
        [ class "box" ]
        [ div
            [ class "container" ]
            [ div
                [ class "row" ]
                [ div
                    [ class "col-md-12" ]
                    [ h1
                        []
                        [ Ui.Rotator.view
                            { left = "Fine cheeses from", right = props.rotator }
                        ]
                    ]
                ]
            ]
        ]


featureBox title content bg =
    div
        [ class "col-sm-4" ]
        [ div
            [ style [ ( "background-image", "url(" ++ bg ++ ")" ) ]
            , class "featureThumb"
            ]
            []
        , div
            [ class "box same-height clickable"
            , style
                [ ( "height", "auto" )
                ]
            ]
            [ h3
                []
                [ a
                    [ href "#" ]
                    [ text title ]
                ]
            , p
                []
                content
            ]
        ]


features =
    div
        [ class "features" ]
        [ div
            [ class "container" ]
            [ div
                [ class "same-height-row row" ]
                [ featureBox "Platters" [ text "Gotch'er platters here!" ] "/img/feature-1.jpg"
                , featureBox "Baskets" [ text "Gotch'er baskets here!" ] "/img/feature-2.jpg"
                , featureBox "Tastings" [ text "Want a taste? Yum!" ] "/img/feature-3.jpg"
                ]
            ]
        ]


view : Props -> Html
view props =
    div
        [ class "pageHome" ]
        [ heroImage
        , rotator props
        , features
        ]
