module Main.Models exposing (..)

import Technologies.Models exposing (Technologies, Technology)
import Categories.Models exposing (Categories)
import Descriptions.Models exposing (Descriptions, descriptionsInit)


---- MODEL ----


type alias Data =
    { descriptions : Descriptions
    , categories : Categories
    , technologies : List Technology
    }


type alias ResponseData =
    { data : Data
    }


type alias ModelData =
    { descriptions : Descriptions
    , categories : Categories
    , technologies : Technologies
    }


type alias Model =
    { sideBarOpen : Bool
    , mainImage : String
    , data : ModelData
    }
