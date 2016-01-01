module Admin.Ui.Products (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Signal
import Models.User exposing (User)
import Models.Product exposing (Product, getAllProducts, emptyProduct, sort)
import Admin.Ui.Utils.Message exposing (message)


thumbnail : String -> Html
thumbnail url =
    div [ style [ ( "background-image", "url(" ++ url ++ ")" ) ], class "thumb" ] []


renderProduct : Props -> Product -> Html
renderProduct props prod =
    let
        price =
            case prod.price of
                "" ->
                    text ""

                _ ->
                    text ("Price: $" ++ prod.price)
    in
        li
            [ class "product" ]
            [ thumbnail prod.image
            , div
                [ class "info" ]
                [ div [ class "name" ] [ text prod.name ]
                , div [ class "description" ] [ text prod.description ]
                , div [] [ text ("Category: " ++ prod.category) ]
                , div [] [ text ("Variant: " ++ prod.variant) ]
                , div [] [ price ]
                ]
            , div
                [ class "buttonBar" ]
                [ button
                    [ class "btn btn-default btn-sm"
                    , onClick props.onEdit prod.id
                    ]
                    [ text "Edit" ]
                ]
            ]


type alias Props =
    { user : User
    , onEdit : Signal.Address String
    , onNew : Signal.Address ()
    , products : List Product
    }


view : Props -> Html
view props =
    div
        [ class "adminProducts" ]
        [ div
            []
            [ div
                [ class "section products" ]
                [ div
                    [ class "productHeader" ]
                    [ h2 [] [ text "Products" ]
                    , button
                        [ class "btn btn-success"
                        , onClick props.onNew ()
                        ]
                        [ text "New Product" ]
                    , div [ class "clearfix" ] []
                    ]
                , ul
                    [ class "productList" ]
                    (List.map (renderProduct props) (sort props.products))
                ]
            ]
        ]
