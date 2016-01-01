module Ui.Baskets (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import ViewHelpers exposing (inGrid, inRow)
import Models.Product exposing (Product)
import List exposing (map, filter, sortBy)
import List.Extra exposing (dropDuplicates)
import Ui.PageHeader exposing (pageHeader)
import Ui.ProductPage exposing (productPage)


type alias Props =
    { products : List Product
    }


subheader =
    div
        []
        [ p [] [ text "Baskets are blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah" ]
        ]


view : Props -> Html
view props =
    productPage
        { products = props.products
        , category = "Baskets"
        , header = "Baskets"
        , subheader = subheader
        , pageClass = "pageBaskets"
        }
