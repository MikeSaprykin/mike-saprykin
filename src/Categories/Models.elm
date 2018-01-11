module Categories.Models exposing (..)


type alias Categories =
    List Category


type alias SelectedCategory =
    Maybe ( String, String )


type alias Category =
    { id : String
    , title : String
    , technologies : List String
    }


categoriesInit : Categories
categoriesInit =
    []
