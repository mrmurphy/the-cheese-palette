module Admin.Ui.EditProduct (..) where

import Signal exposing (Address)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import ViewHelpers exposing (inGrid, inRow)
import FormHelpers exposing (textInput, numberInput)
import Models.Product exposing (Product)


type alias Props =
    { title : String
    , model : Product
    , update : Address Product
    , save : Address Product
    , cancel : Address ()
    , error : String
    }


setName : Product -> String -> Product
setName model name =
    { model | name = name }


setDescription : Product -> String -> Product
setDescription model description =
    { model | description = description }


setImage : Product -> String -> Product
setImage model image =
    { model | image = image }


setCategory : Product -> String -> Product
setCategory model category =
    { model | category = category }


setVariant : Product -> String -> Product
setVariant model variant =
    { model | variant = variant }


setPrice : Product -> String -> Product
setPrice model price =
    { model | price = price }


setSortIndex : Product -> Int -> Product
setSortIndex model idx =
    { model | sortIndex = idx }


view : Props -> Html
view props =
    inGrid
        <| inRow
        <| div
            [ class "editProduct" ]
            [ h1 [] [ text props.title ]
            , label [] [ text "Name" ]
            , textInput
                props.update
                props.model.name
                (setName props.model)
            , label [] [ text "Description" ]
            , textInput
                props.update
                props.model.description
                (setDescription props.model)
            , div
                []
                [ label [] [ text "Image" ]
                  -- TODO: Provide an image uploader
                , textInput
                    props.update
                    props.model.image
                    (setImage props.model)
                , div
                    [ class "thumbPreview"
                    , style [ ( "background-image", "url(" ++ props.model.image ++ ")" ) ]
                    ]
                    []
                ]
            , label [] [ text "Category" ]
            , textInput
                props.update
                props.model.category
                (setCategory props.model)
            , label [] [ text "Variant" ]
            , textInput
                props.update
                props.model.variant
                (setVariant props.model)
            , label [] [ text "Price" ]
            , textInput
                props.update
                props.model.price
                (setPrice props.model)
            , label [] [ text "Sort Index (lower numbers come first on the page)" ]
            , numberInput
                props.update
                props.model.sortIndex
                (setSortIndex props.model)
            , div
                [ class "buttonRow" ]
                [ button
                    [ class "btn btn-warning"
                    , onClick props.cancel ()
                    ]
                    [ text "Cancel" ]
                , button
                    [ class "btn btn-primary"
                    , onClick props.save props.model
                    ]
                    [ text "Save" ]
                ]
            ]
