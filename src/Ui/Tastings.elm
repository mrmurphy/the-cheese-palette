module Ui.Tastings (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Ui.ProductPage exposing (productPage)
import Models.Product exposing (Product)


type alias Props =
    { products : List Product
    }


subheader =
    div
        []
        [ p [] [ text "Cheese tastings are blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah" ]
        , p [ class "attention" ] [ text "If you want to make specific cheese selections, or you have more than 14 people, please contact us directly for arrangements." ]
        ]


view : Props -> Html
view props =
    productPage
        { products = props.products
        , category = "Tastings"
        , header = "Cheese Tastings"
        , subheader = subheader
        , pageClass = "pageTastings"
        }
