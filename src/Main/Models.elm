module Main.Models exposing (..)
import Technologies.Models exposing (Technologies)
import Technologies.Mock exposing (mockTechnologies)
import Categories.Models exposing (Categories)
import Categories.Mocks exposing (categoriesMocks)

---- MODEL ----

type alias Description =
    { icon : String
    , title : String
    , description : String
    , id : String
    }


type alias Descriptions =
    { data : DescriptionsData
    }


type alias DescriptionsData =
    { descriptions : List Description
    }



type alias Model =
    { sideBarOpen : Bool
    , mainImage : String
    , descriptions : Maybe Descriptions
    , technologies : Technologies
    , categories : Categories
    }
