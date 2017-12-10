module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Decode
import Json.Encode as Encode
import AboutMe exposing (generateAboutMeView, defaultAboutMeData)


---- MODEL ----


type alias HttpResData =
    { userId : Int
    , id : Int
    , title : String
    , body : String
    }


type alias Model =
    { sideBarOpen : Bool
    , mainImage : String
    , response : Maybe HttpResData
    }


init : ( Model, Cmd Msg )
init =
    ( { sideBarOpen = False
      , mainImage = ""
      , response = Nothing
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
    | LoadDataResult (Result Http.Error HttpResData)


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
            Http.post graphQLApiUrl (generateQuery descriptionsQuery) decodeData
    in
        Http.send LoadDataResult request


decodeData : Decode.Decoder HttpResData
decodeData =
    Decode.map4 HttpResData
        (Decode.field "title" Decode.int)
        (Decode.field "_id" Decode.int)
        (Decode.field "description" Decode.string)
        (Decode.field "icon" Decode.string)



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


generatePostData : Model -> Html Msg
generatePostData model =
    div [] (generateConditionalPostData model)


generateConditionalPostData : Model -> List (Html Msg)
generateConditionalPostData model =
    case model.response of
        Just response ->
            [ p [] [ text response.title ]
            , p [] [ text response.body ]
            ]

        Nothing ->
            []


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
        , generateAboutMeView defaultAboutMeData
        , hr [] []
        , generatePostData model
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
