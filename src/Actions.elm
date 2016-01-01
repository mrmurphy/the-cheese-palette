module Actions (..) where

import Admin.Actions
import Models.User exposing (Creds, User)


type Action
    = ReactToPathChange String
    | GoToPath String
    | NoOp
    | Admin Admin.Actions.Action
    | UpdateRotator String
    | UpdateCreds Creds
    | UpdateUser User
    | SubmitLogin Creds
    | LogOut
    | ShowError String
