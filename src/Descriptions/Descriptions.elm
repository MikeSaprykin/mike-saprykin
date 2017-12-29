module Descriptions exposing (..)


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
