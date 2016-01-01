module Models.User (..) where

type alias Creds =
  { username : String
  , password : String
  }

type alias User =
  { username: String
  , token : String
  }
