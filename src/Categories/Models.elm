module Categories.Models exposing (..)


type alias Categories =
    { selected : SelectedCategory
    , data : CategoriesData
    }


type alias CategoriesData =
    { categories : List Category }


type alias SelectedCategory =
    Maybe ( String, String )


type alias Category =
    { id : String
    , title : String
    , technologies : List String
    }


categoriesInit : Categories
categoriesInit =
    { selected = Nothing
    , data =
        { categories = []
        }
    }
