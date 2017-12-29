module Main exposing (..)

import Html exposing (program)
import Technologies.Mock exposing (mockTechnologies)
import Categories.Models exposing (categoriesInit)
import Descriptions.Models exposing (descriptionsInit)
import Main.Request exposing (loadData)
import Main.Models exposing (Model)
import Main.Update exposing (Msg, update)
import Main.View exposing (view)


---- PROGRAM ----


init : ( Model, Cmd Msg )
init =
    ( { sideBarOpen = False
      , mainImage = ""
      , data =
            { categories = categoriesInit
            , descriptions = descriptionsInit
            }
      , technologies = mockTechnologies
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
