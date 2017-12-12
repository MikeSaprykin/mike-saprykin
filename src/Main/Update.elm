module Main.Update exposing (..)
import Http
import Main.Models exposing (..)
import Categories.Update as Categories exposing (categoryUpdate)

type Msg
    =
    CategoryMsg Categories.Msg
    | ToggleSideBar
    | LoadData
    | LoadDataResult (Result Http.Error Descriptions)
    | None


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
            ( { model | descriptions = Just data }, Cmd.none )

        LoadDataResult (Err _) ->
            ( model, Cmd.none )
        CategoryMsg msg ->
            let
                categories = model.categories
            in
                ( { model | categories = categoryUpdate msg categories }, Cmd.none)
