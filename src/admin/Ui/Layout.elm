module Admin.Ui.Layout (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Models.User exposing (User)
import ViewHelpers exposing (inRow, inGrid)
import Admin.Ui.Utils.Message exposing (message)
import Signal exposing (Address)


navigation : Props -> Html
navigation props =
    nav
        [ class "navbar navbar-default" ]
        [ div
            [ class "container-fluid" ]
            [ div
                [ class "navbar-header" ]
                [ a
                    [ class "navbar-brand" ]
                    [ text ("Monger's Place : " ++ props.user.username) ]
                ]
            , p
                [ class "navbar-text navbar-right"
                , style [ ( "margin-right", "0" ) ]
                ]
                [ button
                    [ class "navbarButton"
                    , onClick props.onLogout () ]
                    [ text "Log Out" ]
                ]
            ]
        ]


type alias Props =
    { user : User
    , flash : String
    , error : String
    , onLogout : Address ()
    }


wrap : Props -> Html -> Html
wrap props children =
    div
        [ class "admin layout" ]
        [ navigation props
        , inGrid
            << inRow
            <| div
                []
                [ div
                    [ class "flash" ]
                    [ message
                        "success"
                        (props.flash /= "")
                        "flash"
                        [ text props.flash ]
                    ]
                , if props.error /= "" then
                    div [ class "alert alert-danger" ] [ text props.error ]
                  else
                    div [] []
                , children
                ]
        ]
