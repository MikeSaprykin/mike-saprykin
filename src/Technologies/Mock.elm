module Technologies.Mock exposing (..)

import Technologies.Models exposing (..)
import Dict exposing (..)


mockTechnologies : Technologies
mockTechnologies =
    Dict.fromList mockTechnologyList


mockTechnologyList : List ( String, Technology )
mockTechnologyList =
    [ ( "123"
      , { id = "123"
        , icon = "test1"
        , title = "test1"
        , details = Nothing
        }
      )
    , ( "124"
      , { id = "124"
        , icon = "test2"
        , title = "test2"
        , details = Nothing
        }
      )
    , ( "125"
      , { id = "125"
        , icon = "test3"
        , title = "test3"
        , details = Nothing
        }
      )
    ]
