module Ui.Cheeses (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import ViewHelpers exposing (inGrid, inRow)
import Models.Product exposing (Product)
import List exposing (map, filter, sortBy)
import List.Extra exposing (dropDuplicates)
import Ui.PageHeader exposing (pageHeader)


headerBox =
    div
        [ class "box" ]
        [ h1
            []
            [ text "Cheeses" ]
        , p
            []
            [ text "" ]
        ]


type alias Props =
    { products : List Product
    }


variants : List Product -> List String
variants ps =
    dropDuplicates
        <| map .variant
        <| filter (\p -> p.category == "Cheeses") ps


getVariant : String -> List Product -> List Product
getVariant variant ps =
    sortBy .name
        <| filter (\p -> p.variant == variant) ps


renderCheese cheese =
    li
        [ class "cheese row" ]
        [ div
            [ class "col-xs-12" ]
            [ div
                [ class "thumbnail col-sm-3"
                , style [ ( "background-image", "url(" ++ cheese.image ++ ")" ) ]
                ]
                []
            , div
                [ class "col-sm-9" ]
                [ h3 [] [ text cheese.name ]
                , span [ class "description" ] [ text cheese.description ]
                , div [ class "clearfix" ] []
                ]
            ]
        ]


renderVariant : List Product -> String -> Html
renderVariant ps variant =
    div
        [ class "variant box" ]
        [ h2 [] [ text variant ]
        , ul
            [ class "cheeses" ]
            (map renderCheese (getVariant variant ps))
        ]


view : Props -> Html
view props =
    div
        [ class "pageCheeses showcase" ]
        [ pageHeader "Cheeses" (div [] [ text "We source fine cheeses from all over the world. We love to have fun with it. Volunteering your time; it pays you and your whole community fantastic dividends. It's important to me that you're happy. That's what painting is all about. It should make you feel good when you paint." ])
        , inGrid
            << inRow
            <| ul
                [ class "variantList" ]
                (map
                    (renderVariant props.products)
                    (variants props.products)
                )
        ]
