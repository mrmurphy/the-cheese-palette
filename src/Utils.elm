module Utils where

import History
import Task
import Effects exposing (Effects)
import Actions exposing (..)


changePath : String -> Effects Action
changePath newPath =
  Effects.task (Task.map (\_ -> NoOp) (History.setPath newPath))
