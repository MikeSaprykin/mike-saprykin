module Categories.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Categories.Models exposing (..)
import Technologies.Models exposing (..)
import Technologies.Views exposing (..)
import Categories.Update exposing (..)
import Dict exposing (get)
import Tuple exposing (first, second)
import Utils exposing (noElement)


generateCategories : Categories -> Technologies -> Html msg
generateCategories categories technologies =
    div [ class "categories-block" ]
        (categories.data
            |> List.map
                (\i ->
                    technologies |> generateSelectedOrNotCategoryBlock i categories.selected
                )
        )


generateSelectedOrNotCategoryBlock : Category -> SelectedCategory -> Technologies -> Html msg
generateSelectedOrNotCategoryBlock category selected =
    case selected of
        Just selected ->
            if first selected == category.id then
                generateSelectedBlock category
            else
                generateNotSelectedBlock category

        Nothing ->
            generateNotSelectedBlock category


generateSelectedBlock : Category -> Technologies -> Html msg
generateSelectedBlock category technologies =
    div
        [
            class "category-item"
            , class "category-selected"
        ]
        [ h2 []
            [ text category.title
            , hr [] []
            , p [] [ text "Technologies" ]
            ]
        , div
            []
            []
        ]


generateNotSelectedBlock : Category -> Technologies -> Html msg
generateNotSelectedBlock category technologies =
    div
        [ class "category-item"
        ]
        [ h2 []
            [ text category.title
            , hr [] []
            , p [] [ text "Technologies" ]
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
                (get id technologies)
                    |> generateTechnologyIfExists id
            )


generateTechnologyIfExists : String -> Maybe Technology  -> Html msg
generateTechnologyIfExists id technology =
    case technology of
        Just technology ->
            div [
            ]
            [ generateTechnologyItem ( technology.id, technology ) ]

        Nothing ->
            noElement
