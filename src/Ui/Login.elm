module Ui.Login (..) where

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Signal exposing (Address)
import FormHelpers exposing (textInput, passwordInput)
import ViewHelpers exposing (inRow, inGrid)
import Models.User exposing (User, Creds)


type alias Props =
    { creds : Creds
    , onChange : Address Creds
    , onSubmit : Address Creds
    , onError : Address String
    , error : String
    }


view : Props -> Html
view props =
    let
        creds = props.creds

        upName = (\name -> { creds | username = name })

        upPass = (\pass -> { creds | password = pass })
    in
        inGrid
            << inRow
            <| div
                [ class "loginWrapper" ]
                [ h1 [] [ text "Login" ]
                , label [] [ text "Username" ]
                , textInput props.onChange props.creds.username upName
                , label [] [ text "Password" ]
                , passwordInput props.onChange props.creds.password upPass
                , button
                    [ class "btn btn-primary"
                    , onClick props.onSubmit props.creds
                    ]
                    [ text "Submit" ]
                , div [ class "errorMessage" ] [ text props.error ]
                ]



-- Effects
-- submitLogin : Props -> User -> Effects Action
-- submitLogin props u =
--     Db.auth u.username u.password
--         |> Task.toResult
--         |> Task.map
--             (\res ->
--                 case res of
--                     Ok user ->
--                         SetUser user
--
--                     Err err ->
--                         ShowMessage err
--             )
--
--
-- redirectToHome : Effects Action
-- redirectToHome =
--     History.setPath "/products"
--         |> Task.map (always NoOp)
--         |> Effects.task
