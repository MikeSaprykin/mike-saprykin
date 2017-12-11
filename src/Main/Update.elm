module Main.Update exposing (..)
import Http
import Main.Models exposing (..)
import Categories.Update exposing (..)

type Msg
    =
    CategoryMsg CategoriesMsg
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
            ( { model | response = Just data }, Cmd.none )

        LoadDataResult (Err _) ->
            ( model, Cmd.none )
        CategoryMsg (SelectCategoryTechnology selected) ->
            let
                msg = SelectCategoryTechnology selected
                categories = model.categories
            in
                ( { model | categories = categoryUpdate msg categories }, Cmd.none)
        CategoryMsg UnSelectCategoryTechnology ->
            let
                msg = UnSelectCategoryTechnology
                categories = model.categories
            in
                ( { model | categories = categoryUpdate msg categories }, Cmd.none)