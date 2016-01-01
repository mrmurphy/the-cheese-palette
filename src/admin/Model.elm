module Admin.Model (..) where

import Effects exposing (Effects)
import Admin.Actions exposing (..)
import Routes exposing (Route)
import Task exposing (Task, andThen, sleep, succeed)
import Models.Product as Product exposing (emptyProduct, Product, getAllProducts, saveProduct, newProduct)
import Utils exposing (changePath)
import Models.User exposing (User)


type alias Model =
    { editingProduct : Product.Product
    , products : List Product
    , error : String
    , pending : Bool
    , flash : String
    }


init : String -> ( Model, Effects Action )
init initialPath =
    ( { editingProduct = Product.emptyProduct
      , products = []
      , error = ""
      , pending = False
      , flash = ""
      }
    , fetchProducts
    )


updateProductInPlace : Product -> List Product -> List Product
updateProductInPlace p ps =
    let
        isInList = (List.length (List.filter (\i -> i.id == p.id) ps)) /= 0
    in
        if isInList then
            List.map
                (\i ->
                    if i.id == p.id then
                        p
                    else
                        i
                )
                ps
        else
            p :: ps


fetchProducts : Effects Action
fetchProducts =
    getAllProducts FetchProductsFin DisplayError


getProduct : String -> List Product -> Product
getProduct id products =
    Maybe.withDefault emptyProduct
        <| List.head
        <| List.filter (\p -> p.id == id) products


clearFlash : Effects Action
clearFlash =
    Effects.task
        <| sleep 2000
        `andThen` \_ -> succeed ClearFlash


sortProducts : List Product -> List Product
sortProducts =
    List.sortBy .name


type alias Props =
    { activeRoute : Route
    , user: User
    }


update : Props -> Action -> Model -> ( Model, Effects Action )
update props action model =
    case action of
        EditProduct id ->
            ( { model | editingProduct = getProduct id model.products }
            , Effects.map (always NoOp) (changePath ("/#/admin/products/edit/" ++ id))
            )

        UpdateEditingProduct prod ->
            ( { model | editingProduct = prod }
            , Effects.none
            )

        DisplayError e ->
            ( { model | error = e }
            , Effects.none
            )

        FetchProductsFin ps ->
            let
                editing =
                    case props.activeRoute of
                        Routes.EditProduct id ->
                            getProduct id ps

                        _ ->
                            model.editingProduct
            in
                ( { model | products = ps, editingProduct = editing }
                , Effects.none
                )

        SaveProduct p ->
            ( { model | pending = True, error = "" }
            , saveProduct props.user.token p SaveProductFin DisplayError
            )

        SaveProductFin p ->
            ( { model
                | products = (updateProductInPlace p model.products)
                , editingProduct = emptyProduct
                , flash = "Product saved!"
                , pending = False
              }
            , Effects.batch
                [ Effects.map (always NoOp) (changePath "/#/admin/products")
                , clearFlash
                ]
            )

        CancelEditingProduct ->
            ( { model | editingProduct = emptyProduct }
            , Effects.map (always NoOp) (changePath "/#/admin/products")
            )

        NewProduct ->
            ( { model | editingProduct = emptyProduct }
            , Effects.map (always NoOp) (changePath "/#/admin/products/new")
            )

        SaveNewProduct p ->
            ( { model | pending = True, error = "" }
            , newProduct props.user.token p SaveProductFin DisplayError
            )

        ClearFlash ->
            ( { model | flash = "" }
            , Effects.none
            )

        NoOp ->
            ( model
            , Effects.none
            )


onlyModel : ( Model, Effects Action ) -> Model
onlyModel tuple =
    let
        ( model, effects ) = tuple
    in
        model


onlyEffects : ( Model, Effects Action ) -> Effects Action
onlyEffects tuple =
    let
        ( model, effects ) = tuple
    in
        effects
