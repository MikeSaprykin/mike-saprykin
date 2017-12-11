module Categories.Models exposing (..)


type alias Categories =
    List Category


type alias Category =
    { id : String
    , title : String
    , technologies : List String
    }
