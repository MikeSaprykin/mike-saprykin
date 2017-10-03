module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Sidebar exposing (..)


---- MODEL ----


type alias Model =
    { sideBar : SideBar
    , mainImage : String
    }


init : ( Model, Cmd Msg )
init =
    ( { sideBar = sideBarState
      , mainImage = ""
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = None
    | SideBarMsg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        None ->
            ( model, Cmd.none )

        ToggleSideBar ->
            let
                newModel = { model | sideBar = sideBarUpdate msg model.sideBar }
            in
                (update None newModel, Cmd.none)



---- VIEW ----

hamburgerOpen =
    "hamburger active"


hamburgerClosed =
    "hamburger"


hamburgerBar =
    "hamburger__bar"


hamburgerClass : Bool -> Attribute Msg
hamburgerClass open =
    conditionalClassToggle open hamburgerOpen hamburgerClosed


generateHamburgerBars : List (Html Msg)
generateHamburgerBars =
    List.map (\n -> span [ class hamburgerBar ] []) (List.range 1 3)


sideBarHamburger : Bool -> Html Msg
sideBarHamburger sideBarOpen =
    div [ onClick ToggleSideBar, hamburgerClass sideBarOpen ]
        generateHamburgerBars


view : Model -> Html Msg
view model =
    div [ class "side-bar-container" ]
        [ sideBarView
        , sideBarHamburger model.sideBar.sideBarOpen
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
