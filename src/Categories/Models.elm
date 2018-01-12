module Categories.Models exposing (..)

type alias Categories =
    { data : List Category
    , selected : SelectedCategory
    }

type alias SelectedCategory =
    Maybe ( String, String )


type alias Category =
    { id : String
    , title : String
    , technologies : List String
    }


categoriesInit : Categories
categoriesInit =
    { data = []
    , selected = Nothing
    }
