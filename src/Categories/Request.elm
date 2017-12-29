module Categories.Request exposing (..)

import Categories.Models exposing (Categories, CategoriesData, Category)
import Json.Decode as Decode exposing (..)

categoriesQuery : String
categoriesQuery =
    """
        categories {
            _id
            title
            technologies
        }
    """


type alias CategoriesResData =
    {
        data : CategoriesData
    }

categoriesDecoder : Decode.Decoder Categories
categoriesDecoder =
    Decode.map2 Categories
        (field "selected" (Decode.null Nothing))
        (field "data" decodeCategoriesData)


decodeCategoriesData : Decode.Decoder CategoriesData
decodeCategoriesData =
    Decode.map CategoriesData
        (field "descriptions" (Decode.list decodeCategoryItem))


decodeCategoryItem : Decode.Decoder Category
decodeCategoryItem =
    Decode.map3 Category
        (field "title" Decode.string)
        (field "_id" Decode.string)
        (field "categories" (Decode.list Decode.string))
