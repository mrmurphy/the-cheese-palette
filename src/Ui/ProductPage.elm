module Ui.ProductPage (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import ViewHelpers exposing (inGrid, inRow)
import Models.Product exposing (Product, sort)
import List exposing (map, filter, sortBy)
import List.Extra exposing (dropDuplicates)
import Ui.PageHeader exposing (pageHeader)


type alias Props =
    { products : List Product
    , category : String
    , header : String
    , subheader : Html
    , pageClass : String
    }


renderProduct product =
    li
        [ class "product box row" ]
        [ div
            [ class "thumbnail col-xs-12 col-sm-3"
            , style [ ( "background-image", "url(" ++ product.image ++ ")" ) ]
            ]
            []
        , div
            [ class "col-xs-12 col-sm-9" ]
            [ h2 [] [ text product.name ]
            , div [ class "description" ] [ text product.description ]
            ]
        ]


productPage : Props -> Html
productPage props =
    div
        [ class ("showcase " ++ props.pageClass) ]
        [ pageHeader props.header props.subheader
        , inGrid
            << inRow
            <| ul
                [ class "productList" ]
                (map
                    renderProduct
                    (filter (\p -> p.category == props.category) (sort props.products))
                )
        ]
