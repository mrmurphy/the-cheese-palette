module Model (..) where

import Effects exposing (Effects)
import Admin.Model
import Models.User exposing (User, Creds)
import Actions exposing (..)
import Routes exposing (Route)
import Utils exposing (changePath)
import Models.Product exposing (Product)
import Helpers exposing (effectify, actionify)
import Db


type alias Model =
    { admin : Admin.Model.Model
    , activeRoute : Route
    , rotator : String
    , products : List Product
    , user : User
    , creds : Creds
    , error : String
    }


init : String -> User -> ( Model, Effects Action )
init initialPath initialUser =
    let
        adminInit = Admin.Model.init initialPath
    in
        ( { admin = Admin.Model.onlyModel adminInit
          , activeRoute = Routes.getRoute initialPath
          , rotator = "Utah"
          , products = []
          , user = initialUser
          , creds = { username = "", password = "" }
          , error = ""
          }
        , Effects.map Admin (Admin.Model.onlyEffects adminInit)
        )


update : Action -> Model -> ( Model, Effects Action )
update action model =
    case action of
        NoOp ->
            ( model, Effects.none )

        GoToPath newPath ->
            ( model
            , changePath newPath
            )

        ReactToPathChange newPath ->
            ( { model | activeRoute = Routes.getRoute newPath }, Effects.none )

        -- Pages!
        Admin subAction ->
            -- TODO: Refactor so that products are only kept at the root, instead
            --       of both the root and inside of admin.
            let
                updated =
                    Admin.Model.update
                        { activeRoute = model.activeRoute, user = model.user }
                        subAction
                        model.admin

                products = (fst updated).products
            in
                -- Hacky, I'm making the action from the admin's products request update
                -- the root products. Refactor this later.
                ( { model | admin = (fst updated), products = products }
                , Effects.map Actions.Admin (snd updated)
                )

        UpdateRotator v ->
            ( { model | rotator = v }
            , Effects.none
            )

        UpdateCreds creds ->
            ( { model | creds = creds }
            , Effects.none
            )

        UpdateUser user ->
            ( { model | user = user }
            , Effects.none
            )

        SubmitLogin creds ->
            ( model
            , effectify
                <| actionify UpdateUser ShowError
                <| Db.auth creds.username creds.password
            )

        LogOut ->
            ( { model | user = { username = "", token = "" } }
            , Effects.none
            )

        ShowError err ->
            ( { model | error = err }
            , Effects.none
            )
