module Categories.Update exposing (..)

import Categories.Models exposing (..)

type CategoriesMsg
    = SelectCategoryTechnology SelectedCategory
    | UnSelectCategoryTechnology


updateSelected : SelectedCategory -> Categories -> Categories
updateSelected selected categories =
    { categories | selected = selected }

onSelectCategory : Categories -> SelectedCategory -> Categories
onSelectCategory categories selected =
    categories |> updateSelected selected

onUnSelectCategory : Categories -> Categories
onUnSelectCategory categories =
    categories |> updateSelected Nothing


categoryUpdate : CategoriesMsg -> Categories -> Categories
categoryUpdate msg categories =
    case msg of
        SelectCategoryTechnology selected ->
            onSelectCategory categories selected

        UnSelectCategoryTechnology ->
            onUnSelectCategory categories
