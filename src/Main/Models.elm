module Main.Models exposing (..)

import Technologies.Models exposing (Technologies)
import Technologies.Mock exposing (mockTechnologies)
import Categories.Models exposing (Categories)
import Descriptions.Models exposing (Descriptions, descriptionsInit)


---- MODEL ----


type alias ModelData =
    { descriptions : Descriptions
    , categories : Categories
    }


type alias Model =
    { sideBarOpen : Bool
    , mainImage : String
    , data : ModelData
    , technologies : Technologies
    }
