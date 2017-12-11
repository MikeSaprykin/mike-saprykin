module Categories.Models exposing (..)


type alias Categories =
    { selected : SelectedCategory
    , data : List Category
    }


type alias SelectedCategory =
    Maybe ( String, String )


type alias Category =
    { id : String
    , title : String
    , technologies : List String
    }
