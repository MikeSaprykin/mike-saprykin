module Categories.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Categories.Models exposing (..)
import Technologies.Models exposing (..)
import Technologies.Views exposing (..)
import Dict exposing (get)
import Utils exposing (noElement)


generateCategories : Categories -> Technologies -> Html msg
generateCategories categories technologies =
    div [ class "categories-block" ]
        (List.map (\i -> generateCategoryItem i technologies) categories)


generateCategoryItem : Category -> Technologies -> Html msg
generateCategoryItem category technologies =
    div [ class "category-item" ]
        [ h2 []
            [
            text category.title
            , hr [] []
            , p [] [text "Technologies"]
            ]
        , div
            []
            (generateCategoryTechnologies category.technologies technologies)
        ]


generateCategoryTechnologies : List String -> Technologies -> List (Html msg)
generateCategoryTechnologies ids technologies =
    ids
        |> List.map
            (\id ->
                get id technologies
                    |> generateTechnologyIfExists
            )


generateTechnologyIfExists : Maybe Technology -> Html msg
generateTechnologyIfExists technology =
    case technology of
        Just technology ->
            generateTechnologyItem ( technology.id, technology )

        Nothing ->
            noElement
