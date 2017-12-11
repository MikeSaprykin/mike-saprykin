module Categories.Mocks exposing (..)

import Categories.Models exposing (..)


categoriesMocks : Categories
categoriesMocks =
    { selected = Just ( "111", "123" )
    , data = categories
    }


categories : List Category
categories =
    [ { id = "111"
      , title = "Front-End"
      , technologies =
            [ "123"
            ]
      }
    , { id = "112"
      , title = "Backen-End"
      , technologies =
            [ "123"
            , "124"
            , "125"
            ]
      }
    , { id = "113"
      , title = "Frameworks"
      , technologies =
            [ "124"
            ]
      }
    ]
