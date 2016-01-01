module Router (..) where

import Routes
import Signal exposing (Address, forwardTo)
import Html exposing (..)
import Model exposing (Model)
import Ui.Login as Login
import Admin.Ui.Products as Products
import Admin.Ui.EditProduct as EditProduct
import Admin.Ui.Layout as AdminLayout
import Admin.Actions as AdminActions
import Admin.Model as AdminModel
import Ui.Home as Home
import Ui.Cheeses
import Ui.Baskets
import Actions exposing (Action(UpdateCreds, SubmitLogin, ShowError, LogOut))
import Ui.Layout exposing (layout)
import Ui.Platters
import Ui.Tastings


checkLoggedIn : Address Action -> Model -> Html -> Html
checkLoggedIn address model child =
    if model.user.username == "" then
        Login.view
            { creds = model.creds
            , onChange = (forwardTo address UpdateCreds)
            , onSubmit = (forwardTo address SubmitLogin)
            , onError = (forwardTo address ShowError)
            , error = model.error
            }
    else
        child


adminAction : Address Action -> (a -> AdminActions.Action) -> Address a
adminAction address adminAction =
    forwardTo address (Actions.Admin << adminAction)


products : Address Action -> Model.Model -> Html
products address model =
    Products.view
        { user = model.user
        , onEdit = adminAction address AdminActions.EditProduct
        , products = model.products
        , onNew = adminAction address (\_ -> AdminActions.NewProduct)
        }


route : Address Action -> Model -> Html
route address model =
    let
        adminLayout =
            AdminLayout.wrap
                { user = model.user
                , flash = model.admin.flash
                , error = model.admin.error
                , onLogout = (forwardTo address (\_ -> LogOut))
                }
    in
        case model.activeRoute of
            Routes.Home ->
                layout (Home.view { rotator = model.rotator })

            Routes.NotFound ->
                div [] [ text "404, not found!" ]

            Routes.Products ->
                checkLoggedIn address model
                    <| adminLayout (products address model)

            Routes.EditProduct id ->
                adminLayout
                    <| EditProduct.view
                        { title = "Edit Product"
                        , update =
                            adminAction address AdminActions.UpdateEditingProduct
                        , save =
                            adminAction address AdminActions.SaveProduct
                        , cancel =
                            adminAction address (\_ -> AdminActions.CancelEditingProduct)
                        , error = model.admin.error
                        , model = model.admin.editingProduct
                        }

            Routes.NewProduct ->
                adminLayout
                    <| EditProduct.view
                        { title = "New Product"
                        , update =
                            adminAction address AdminActions.UpdateEditingProduct
                        , save =
                            adminAction address AdminActions.SaveNewProduct
                        , cancel =
                            adminAction address (\_ -> AdminActions.CancelEditingProduct)
                        , error = model.admin.error
                        , model = model.admin.editingProduct
                        }

            Routes.Cheeses ->
                layout (Ui.Cheeses.view { products = model.products })

            Routes.Baskets ->
                layout (Ui.Baskets.view { products = model.products })

            Routes.Platters ->
                layout (Ui.Platters.view { products = model.products })

            Routes.Tastings ->
                layout (Ui.Tastings.view { products = model.products })
