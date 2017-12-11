module Categories.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Categories.Models exposing (..)
import Technologies.Models exposing (..)
import Technologies.Views exposing (..)
import Categories.Update exposing (..)
import Main.Update exposing (..)
import Dict exposing (get)
import Tuple exposing (first, second)
import Utils exposing (noElement)


generateCategories : Categories -> Technologies -> Html Msg
generateCategories categories technologies =
    div [ class "categories-block" ]
        (categories.data
            |> List.map
                (\i ->
                    technologies |> generateSelectedOrNotCategoryBlock i categories.selected
                )
        )


generateSelectedOrNotCategoryBlock : Category -> SelectedCategory -> Technologies -> Html Msg
generateSelectedOrNotCategoryBlock category selected =
    case selected of
        Just selected ->
            if first selected == category.id then
                generateSelectedBlock category
            else
                generateNotSelectedBlock category

        Nothing ->
            generateNotSelectedBlock category


generateSelectedBlock : Category -> Technologies -> Html Msg
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


generateNotSelectedBlock : Category -> Technologies -> Html Msg
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
            (generateCategoryTechnologies category technologies)
        ]


generateCategoryTechnologies : Category -> Technologies -> List (Html Msg)
generateCategoryTechnologies category technologies =
    category.technologies
        |> List.map
            (\id ->
                (get id technologies)
                    |> generateTechnologyIfExists category.id
            )


generateTechnologyIfExists : String -> Maybe Technology  -> Html Msg
generateTechnologyIfExists id technology =
    case technology of
        Just technology ->
            div [
                onClick (
                   Just (id, technology.id) |> SelectCategoryTechnology
                                            |> CategoryMsg
                )
            ]
            [ generateTechnologyItem ( technology.id, technology ) ]

        Nothing ->
            noElement
