module Main exposing (..)

import Html exposing (program)
import Technologies.Mock exposing (mockTechnologies)
import Categories.Mocks exposing (categoriesMocks)
import Main.Request exposing (loadData)
import Main.Models exposing (Model)
import Main.Update exposing (Msg, update)
import Main.View exposing (view)


---- PROGRAM ----

init : ( Model, Cmd Msg )
init =
    ( { sideBarOpen = False
      , mainImage = ""
      , descriptions = Nothing
      , technologies = mockTechnologies
      , categories = categoriesMocks
      }
    , loadData
    )

main : Program Never Model Msg
main =
    program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
