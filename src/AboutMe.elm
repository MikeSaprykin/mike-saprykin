module AboutMe exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


type alias AboutMeDataItem =
    { icon : String
    , title : String
    , description : String
    }


defaultAboutMeData : List AboutMeDataItem
defaultAboutMeData =
    [ { icon = "fa"
      , title = "About me"
      , description = """ Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec consequat libero at purus ultrices,
                          vel euismod metus feugiat. Vestibulum placerat nibh nisi, in rutrum leo mollis quis.
                          Nulla quis nisl nec metus auctor dapibus. Curabitur ut nunc id diam ornare tempor.
                          Nulla sollicitudin scelerisque neque, vitae rutrum ipsum tincidunt sit amet.
                          """
      }
    , { icon = "fa"
      , title = "Professional interests"
      , description = """ Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec consequat libero at purus ultrices,
                      vel euismod metus feugiat. Vestibulum placerat nibh nisi, in rutrum leo mollis quis.
                      Nulla quis nisl nec metus auctor dapibus. Curabitur ut nunc id diam ornare tempor.
                      Nulla sollicitudin scelerisque neque, vitae rutrum ipsum tincidunt sit amet.
                      """
      }
    , { icon = "fa"
      , title = "Hobbies"
      , description = """ Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec consequat libero at purus ultrices,
                    vel euismod metus feugiat. Vestibulum placerat nibh nisi, in rutrum leo mollis quis.
                    Nulla quis nisl nec metus auctor dapibus. Curabitur ut nunc id diam ornare tempor.
                    Nulla sollicitudin scelerisque neque, vitae rutrum ipsum tincidunt sit amet.
                    """
      }
    ]


generateAboutMeBlocks : List AboutMeDataItem -> List (Html msg)
generateAboutMeBlocks aboutMeData =
    List.map
        (\item ->
            div []
                [ h3 [ class item.title ] [ text item.title ]
                , p [ class item.title ]
                    [ text item.description ]
                ]
        )
        (aboutMeData)


generateAboutMeView : List AboutMeDataItem -> Html msg
generateAboutMeView aboutMeData =
    div [ class "about-me-block" ] <| generateAboutMeBlocks aboutMeData
