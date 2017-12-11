--Technologies models module


module Technologies.Models exposing (..)
import Dict exposing (..)


type alias Technology =
    { id : String
    , icon : String
    , title : String
    , details : Maybe TechnologyDetail
    }


type alias TechnologyDetail =
    { description : String
    , level : String
    , projects : String
    }


type alias Technologies
    = Dict String Technology
