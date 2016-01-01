module Helpers (..) where

import Task exposing (Task)
import Effects exposing (Effects)


actionify : (thing -> action) -> (String -> action) -> Task error thing -> Task nothing action
actionify onSuccess onError task =
    Task.toResult task
        |> Task.map
            (\res ->
                case res of
                    Ok thing ->
                        onSuccess thing

                    Err error ->
                        onError (toString error)
            )


effectify : Task Effects.Never action -> Effects action
effectify task =
    Effects.task task
