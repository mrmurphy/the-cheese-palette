module Ui.Layout (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Ui.TopBar
import String
import Char


unicode : Int -> String
unicode i =
    String.fromChar (Char.fromCode i)


copyright : Html
copyright =
    div
        [ id "copyright" ]
        [ div
            [ class "container" ]
            [ div
                [ class "col-xs-12" ]
                [ p
                    []
                    [ text ((unicode 169) ++ " 2015 The Cheese Palette.")
                    , img [ src "/img/big-logo.svg", class "bigLogo" ] []
                    ]
                ]
            , div
                [ class "col-xs-12" ]
                [ p
                    []
                    [ text "Template by "
                    , a
                        [ href "http://bootstrapious.com/e-commerce-templates" ]
                        [ text "Bootstrap Ecommerce Templates" ]
                    , text " with support from "
                    , a
                        [ href "http://kakusei.cz" ]
                        [ text ("Designov" ++ (unicode 233) ++ " p" ++ (unicode 345) ++ "edm" ++ (unicode 283) ++ "ty") ]
                    ]
                ]
            ]
        ]


footerColumn : List Html -> Html
footerColumn children =
    div [ class "col-sm-4" ] children


pages : List Html
pages =
    [ h1
        []
        [ text "Pages" ]
    , ul
        []
        [ li
            []
            [ a
                [ href "/cheeses" ]
                [ text "Cheeses" ]
            ]
        , li
            []
            [ a
                [ href "/baskets" ]
                [ text "Baskets" ]
            ]
        , li
            []
            [ a
                [ href "/platters" ]
                [ text "Platters" ]
            ]
        , li
            []
            [ a
                [ href "/tastings" ]
                [ text "Tastings" ]
            ]
        ]
    ]


contact : List Html
contact =
    [ h1
        []
        [ text "Contact Us" ]
    , p
        []
        [ strong
            []
            [ text "The Cheese Palette" ]
        , br [] []
        , text "1058 Lynnwood Dr."
        , br [] []
        , text "Orem, UT"
        , br [] []
        , text "84043"
        , br [] []
        , strong
            []
            [ a
                [ href "tel:801-999-0608" ]
                [ text "(801) 999-0608" ]
            ]
        , br [] []
        , strong
            []
            [ a
                [ href "mailto:hello@cheesepalette.com" ]
                [ text "hello@thecheesepalette.com" ]
            ]
        ]
    ]


social : List Html
social =
    [ h1 [] [ text "Stay in touch" ]
    , p
        [ class "social" ]
        [ a
            [ class "facebook external", href "https://www.facebook.com/cheesepalette/?fref=ts" ]
            [ i [ class "fa fa-facebook" ] [] ]
        , a
            [ class "twitter external", href "https://twitter.com/cheese_palette" ]
            [ i [ class "fa fa-twitter" ] [] ]
        , a
            [ class "instagram external", href "https://www.instagram.com/cheese_palette/" ]
            [ i [ class "fa fa-instagram" ] [] ]
        , a
            [ class "email external", href "mailto:hello@cheesepalette.com" ]
            [ i [ class "fa fa-envelope" ] [] ]
        ]
    ]


footer : Html
footer =
    div
        [ id "footer" ]
        [ div
            [ class "container" ]
            [ div
                [ class "row" ]
                [ footerColumn pages
                , footerColumn contact
                , footerColumn social
                ]
            ]
        ]


layout : Html -> Html
layout child =
    div
        []
        [ Ui.TopBar.view
        , child
        , footer
        , copyright
        ]
