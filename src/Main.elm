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
    ( { sideBarOpen = False
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
--- SIDE BAR ---


conditionalClassToggle : Bool -> String -> String -> Attribute Msg
conditionalClassToggle active activeClass notActiveClass =
    class
        (if active then
            activeClass
         else
            notActiveClass
        )


overlayShowClass : String
overlayShowClass =
    "overlay show-overlay"


overlayHideClass : String
overlayHideClass =
    "overlay hide-overlay"


generateOverlayClass : Bool -> Attribute Msg
generateOverlayClass overlayShow =
    conditionalClassToggle overlayShow overlayShowClass overlayHideClass


generateOverlay : Bool -> Html Msg
generateOverlay show =
    div [ generateOverlayClass show ]
        []


sideBarOpenClass : String
sideBarOpenClass =
    "side-bar side-bar-open"


sideBarClosedClass : String
sideBarClosedClass =
    "side-bar side-bar-closed"


generateSideBarClass : Bool -> Attribute Msg
generateSideBarClass sideBarOpen =
    conditionalClassToggle sideBarOpen sideBarOpenClass sideBarClosedClass


generateSideBar : Bool -> List (Html Msg) -> Html Msg
generateSideBar open elements =
    div [ generateSideBarClass open ] elements


sideBarAnchorBlock : String -> Html Msg
sideBarAnchorBlock anchorText =
    div [ class "side-bar-anchor-wrapper" ]
        [ a [ class "side-bar-anchor", onClick ToggleSideBar ]
            [ text anchorText ]
        ]


sideBarAnchors : List (Html Msg)
sideBarAnchors =
    let
        skills =
            [ "About me", "Skills", "Projects", "Contacts" ]
    in
        skills |> List.map (\s -> sideBarAnchorBlock s)


sideBarMenu : Bool -> Html Msg
sideBarMenu open =
    generateSideBar open sideBarAnchors


sideBarView : Model -> Html Msg
sideBarView sideBarState =
    div [ class "side-bar-container" ]
        [ generateOverlay sideBarState.sideBarOpen
        , sideBarMenu sideBarState.sideBarOpen
        ]



--- END OF SIDE BAR ---


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
    section [ class "app" ]
        [ header [ class "header-block" ]
            [ sideBarHamburger model.sideBarOpen ]
        , section [ class "side-bar-container" ]
            [ sideBarView model ]
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
