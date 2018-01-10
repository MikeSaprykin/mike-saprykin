module Categories.Update exposing (..)

import Categories.Models exposing (..)


type Msg
    = SelectCategoryTechnology SelectedCategory
    | UnSelectCategoryTechnology


--updateSelected : SelectedCategory -> Categories -> Categories
--updateSelected selected categories =
--    { categories | selected = selected }


--onSelectCategory : Categories -> SelectedCategory -> Categories
--onSelectCategory categories selected =
--    categories |> updateSelected selected


--onUnSelectCategory : Categories -> Categories
--onUnSelectCategory categories =
--    categories |> updateSelected Nothing


categoryUpdate : Msg -> Categories -> Categories
categoryUpdate msg categories =
    case msg of
        SelectCategoryTechnology selected ->
            categories

        UnSelectCategoryTechnology ->
            categories
