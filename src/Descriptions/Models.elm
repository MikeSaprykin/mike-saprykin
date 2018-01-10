module Descriptions.Models exposing (..)


type alias Description =
    { icon : String
    , title : String
    , description : String
    , id : String
    }


type alias Descriptions = List Description


descriptionsInit : Descriptions
descriptionsInit = []
