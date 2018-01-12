module Categories.Request exposing (..)

import Categories.Models exposing (Categories, Category)
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


categoriesDecoder : Decode.Decoder (List Category)
categoriesDecoder =
    list decodeCategoryItem


decodeCategoryItem : Decode.Decoder Category
decodeCategoryItem =
    Decode.map3 Category
        (field "_id" string)
        (field "title" string)
        (field "technologies" (list string))
