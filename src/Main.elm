module Main (..) where

import StartApp as StartApp
import Task
import Effects exposing (Never, Effects)
import History
import Signal
import Html exposing (Html, text)
import Task exposing (Task)
import Model exposing (Model)
import Actions exposing (Action)
import Models.User exposing (User)
import Ui.Rotator as Rotator
import Router


view : Signal.Address Action -> Model -> Html
view address model =
    Router.route address model


routeChanges : Signal Action
routeChanges =
    Signal.map Actions.ReactToPathChange History.hash


rotatorChanges : Signal Action
rotatorChanges =
    Signal.map
        Actions.UpdateRotator
        <| Rotator.changes
            [ "Utah"
            , "Finland"
            , "Ireland"
            , "Austria"
            , "New York"
            , "Perelandra"
            , "Norway"
            ]


app : StartApp.App Model
app =
    StartApp.start
        { init = Model.init initialPath userFromStorage
        , update = Model.update
        , view = view
        , inputs = [ routeChanges, rotatorChanges ]
        }


main : Signal Html
main =
    app.html


port tasks : Signal (Task.Task Never ())
port tasks =
    app.tasks



-- Local Storage


port userFromStorage : User
port initialPath : String
port saveUser : Signal User
port saveUser =
    app.model
        |> Signal.map .user
        |> Signal.dropRepeats
