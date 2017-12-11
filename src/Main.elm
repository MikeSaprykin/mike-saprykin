module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Decode exposing (..)
import Json.Decode.Extra exposing (..)
import Json.Encode as Encode
import Technologies.Models exposing (Technologies)
import Technologies.Views exposing (generateTechnologies)
import Technologies.Mock exposing (mockTechnologies)


---- MODEL ----


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


decodeDescription : Decode.Decoder Descriptions
decodeDescription =
    Decode.succeed Descriptions
        |: (field "data" decodeDescriptionData)


decodeDescriptionData : Decode.Decoder DescriptionsData
decodeDescriptionData =
    Decode.succeed DescriptionsData
        |: (field "descriptions" (Decode.list decodeDescriptionItem))


decodeDescriptionItem : Decode.Decoder Description
decodeDescriptionItem =
    map4 Description
        (field "icon" string)
        (field "title" string)
        (field "description" string)
        (field "_id" string)


type alias Model =
    { sideBarOpen : Bool
    , mainImage : String
    , response : Maybe Descriptions
    , technologies : Technologies
    }


init : ( Model, Cmd Msg )
init =
    ( { sideBarOpen = False
      , mainImage = ""
      , response = Nothing
      , technologies = mockTechnologies
      }
    , loadData
    )



---- UPDATE ----


graphQLApiUrl : String
graphQLApiUrl =
    "http://localhost:8080/graphql"


descriptionsQuery : String
descriptionsQuery =
    """
        {
            descriptions {
              title
              _id
              description
              icon
            }
        }
    """


type alias QueryPayload =
    { query : String
    , operationName : String
    , variables : {}
    }


generateQuery : String -> Http.Body
generateQuery query =
    Http.jsonBody
        (Encode.object
            [ ( "query", Encode.string <| query )
            , ( "operationName", Encode.string <| "" )
            , ( "variables", Encode.object [ ( "", Encode.string <| "" ) ] )
            ]
        )


type Msg
    = None
    | ToggleSideBar
    | LoadData
    | LoadDataResult (Result Http.Error Descriptions)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        None ->
            ( model, Cmd.none )

        ToggleSideBar ->
            ( { model | sideBarOpen = not model.sideBarOpen }, Cmd.none )

        LoadData ->
            ( model, Cmd.none )

        LoadDataResult (Ok data) ->
            ( { model | response = Just data }, Cmd.none )

        LoadDataResult (Err _) ->
            ( model, Cmd.none )


loadData : Cmd Msg
loadData =
    let
        request =
            Http.post graphQLApiUrl (generateQuery descriptionsQuery) decodeDescription
    in
        Http.send LoadDataResult request



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
generateAboutMeBlocks model =
    case model.response of
        Just response ->
            let
                items =
                    response.data.descriptions
            in
                items
                    |> List.map generateAboutMeItem

        Nothing ->
            []


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
        , div [] (generateTechnologies model.technologies)
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
