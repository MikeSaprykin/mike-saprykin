module Sidebar exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


-- MODEL


type alias SideBar =
    { sideBarOpen : Bool
    }


sideBarState : SideBar
sideBarState =
    { sideBarOpen = False
    }



-- UPDATE


type SideBarMsg
    = None
    | ToggleSideBar


sideBarUpdate : SideBarMsg -> SideBar -> SideBar
sideBarUpdate msg model =
    case msg of
        None ->
            model

        ToggleSideBar ->
            { model | sideBarOpen = not model.sideBarOpen }



-- VIEW


conditionalClassToggle : Bool -> String -> String -> Attribute SideBarMsg
conditionalClassToggle active activeClass notActiveClass =
    class
        (if active then
            activeClass
         else
            notActiveClass
        )

overlayShowClass: String
overlayShowClass =
    "overlay show-overlay"

overlayHideClass : String
overlayHideClass =
    "overlay hide-overlay"


generateOverlayClass : Bool -> Attribute SideBarMsg
generateOverlayClass overlayShow =
    conditionalClassToggle overlayShow overlayShowClass overlayHideClass


generateOverlay : Bool -> Html SideBarMsg
generateOverlay show =
    div [ generateOverlayClass show ]
        []

sideBarOpenClass : String
sideBarOpenClass =
    "side-bar side-bar-open"

sideBarClosedClass : String
sideBarClosedClass =
    "side-bar side-bar-closed"


generateSideBarClass : Bool -> Attribute SideBarMsg
generateSideBarClass sideBarOpen =
    conditionalClassToggle sideBarOpen sideBarOpenClass sideBarClosedClass


generateSideBar : Bool -> List (Html SideBarMsg) -> Html SideBarMsg
generateSideBar open elements =
    div [ generateSideBarClass open ] elements


sideBarAnchors : List (Html msg)
sideBarAnchors =
    [ a [] [ text "About me" ]
    , a [] [ text "Skills" ]
    , a [] [ text "Projects" ]
    , a [] [ text "Contacts" ]
    ]


sideBarMenu : Bool -> Html SideBarMsg
sideBarMenu open =
    generateSideBar open sideBarAnchors

sideBarView : SideBar -> Html SideBarMsg
sideBarView sideBarState =
    div [ class "side-bar-container" ]
        [ generateOverlay sideBarState.sideBarOpen
        , sideBarMenu sideBarState.sideBarOpen
        ]
