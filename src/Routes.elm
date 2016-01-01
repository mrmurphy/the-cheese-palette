module Routes (..) where

import RouteParser exposing (..)


type Route
    = Home
    | Products
    | NotFound
    | NewProduct
    | EditProduct String
    | Cheeses
    | Baskets
    | Platters
    | Tastings


routeParsers : Parsers Route
routeParsers =
    [ static Home "#/"
    , static Home ""
    , static Products "#/admin/products"
    , static NewProduct "#/admin/products/new"
    , dyn1 EditProduct "#/admin/products/edit/" string ""
    , static Cheeses "#/cheeses"
    , static Baskets "#/baskets"
    , static Platters "#/platters"
    , static Tastings "#/tastings"
    ]


getRoute : String -> Route
getRoute activePath =
    let
        maybeRoute = match routeParsers activePath
    in
        case maybeRoute of
            Just r ->
                r

            Nothing ->
                NotFound
