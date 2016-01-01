module Admin.Actions (..) where

import Models.Product exposing (Product)


type Action
    = EditProduct String
    | UpdateEditingProduct Product
    | FetchProductsFin (List Product)
    | SaveProduct Product
    | SaveProductFin Product
    | CancelEditingProduct
    | NewProduct
    | SaveNewProduct Product
    | DisplayError String
    | ClearFlash
    | NoOp
