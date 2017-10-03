module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


---- MODEL ----


type alias Model =
    { sideBarOpen : Bool
    , mainImage : String
    }


init : ( Model, Cmd Msg )
init =
    (
        { sideBarOpen = False
        , mainImage = ""
        }
        , Cmd.none
    )



---- UPDATE ----


type Msg
    = None
      | ToggleSideBar


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        None ->
            ( model, Cmd.none )

        ToggleSideBar ->
            ( { model | sideBarOpen = not model.sideBarOpen }, Cmd.none )


---- VIEW ----

conditionalClassToggle : Bool -> String -> String -> Attribute Msg
conditionalClassToggle active activeClass notActiveClass =
    class
        (if active then
            activeClass
         else
            notActiveClass
        )


overlayShowClass =
    "overlay show-overlay"


overlayHideClass =
    "overlay hide-overlay"


generateOverlayClass : Bool -> Attribute Msg
generateOverlayClass overlayShow =
    conditionalClassToggle overlayShow overlayShowClass overlayHideClass


generateOverlay : Bool -> Html Msg
generateOverlay show =
    div [ generateOverlayClass show ]
        []


sideBarOpenClass =
    "side-bar-open"


sideBarClosedClass =
    "side-bar-closed"


generateSideBarClass : Bool -> Attribute Msg
generateSideBarClass sideBarOpen =
    conditionalClassToggle sideBarOpen sideBarOpenClass sideBarClosedClass


generateSideBar : Bool -> List (Html Msg) -> Html Msg
generateSideBar open elements =
    div [ generateSideBarClass open ] elements

sideBarAnchors : List (Html msg)
sideBarAnchors =
    [ a [] [text "About me"]
    , a [] [text "Skills"]
    , a [] [text "Projects"]
    , a [] [text "Contacts"]
    ]

sideBarMenu : Bool -> Html Msg
sideBarMenu open =
    generateSideBar open sideBarAnchors


hamburgerOpen =
    "hamburger active"


hamburgerClosed =
    "hamburger"

hamburgerBar =
    "hamburger__bar"

hamburgerClass : Bool -> Attribute Msg
hamburgerClass open =
    conditionalClassToggle open hamburgerOpen hamburgerClosed


generateHamburgerBars: List (Html Msg)
generateHamburgerBars =
    List.map (\n -> span [ class hamburgerBar ] []) (List.range 1 3)

sideBarHamburger : Bool -> Html Msg
sideBarHamburger sideBarOpen =
    div [ onClick ToggleSideBar, hamburgerClass sideBarOpen ]
        generateHamburgerBars


view : Model -> Html Msg
view model =
    div [ class "side-bar" ]
        [ generateOverlay model.sideBarOpen
        , sideBarMenu model.sideBarOpen
        , sideBarHamburger model.sideBarOpen
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
