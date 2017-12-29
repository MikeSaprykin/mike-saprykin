module Main.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Main.Update exposing (..)
import Main.Models exposing (..)
import Categories.View exposing (generateCategories)
import Descriptions.Models exposing (..)


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
        skills |> List.map sideBarAnchorBlock


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


hamburgerOpen : String
hamburgerOpen =
    "hamburger active"


hamburgerClosed : String
hamburgerClosed =
    "hamburger"


hamburgerBar : String
hamburgerBar =
    "hamburger__bar"


hamburgerClass : Bool -> Attribute Msg
hamburgerClass open =
    conditionalClassToggle open hamburgerOpen hamburgerClosed


generateHamburgerBars : List (Html Msg)
generateHamburgerBars =
    List.range 1 3 |> List.map (\n -> span [ class hamburgerBar ] [])


sideBarHamburger : Bool -> Html Msg
sideBarHamburger sideBarOpen =
    div [ onClick ToggleSideBar, hamburgerClass sideBarOpen ]
        generateHamburgerBars


generateAboutMeItem : Description -> Html msg
generateAboutMeItem item =
    div []
        [ h3 [ class item.title ] [ text item.title ]
        , i [ class item.icon ] []
        , p [] [ text item.description ]
        ]


generateAboutMeBlocks : Model -> List (Html msg)
generateAboutMeBlocks { data } =
    List.map generateAboutMeItem data.descriptions.data.descriptions


generateAboutMeView : Model -> Html msg
generateAboutMeView model =
    div [ class "about-me-block" ] <| generateAboutMeBlocks model


view : Model -> Html Msg
view model =
    div [ class "app" ]
        [ header [ class "header-block" ]
            [ sideBarHamburger model.sideBarOpen
            , div [ class "header-overlay" ] []
            , div [ class "header-description" ]
                [ h1 [] [ text "Mike Saprykin" ]
                , h2 [] [ text "Software Engineer" ]
                ]
            , div [ class "header-image" ] []
            ]
        , div [ class "side-bar-container" ]
            [ sideBarView model ]
        , generateAboutMeView model
        , hr [] []
        , Html.map CategoryMsg (generateCategories model.data.categories model.technologies)
        ]
