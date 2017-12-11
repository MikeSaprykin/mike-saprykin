--Technologies views module


module Technologies.Views exposing (..)

import Technologies.Models exposing (..)
import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (..)


generateTechnologies : Technologies -> List (Html msg)
generateTechnologies technologies =
    Dict.toList technologies
        |> List.map generateTechnologyItem


generateTechnologyItem : ( String, Technology) -> Html msg
generateTechnologyItem (key, technology) =
    div [ class "technology-item" ]
        [ p [] [ text technology.icon ]
        , p [] [ text technology.title ]
        , p [] [ text technology.id ]
        ]
