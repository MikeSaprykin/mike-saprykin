module Main.Update exposing (..)

import Http
import Main.Models exposing (..)
import Categories.Update as Categories exposing (categoryUpdate)
import Debug exposing (log)


type Msg
    = CategoryMsg Categories.Msg
    | ToggleSideBar
    | LoadData
    | LoadDataResult (Result Http.Error ModelData)
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
            let
                data =
                    model.data
                newData =
                    { data | descriptions = data.descriptions }
                newModel =
                    { model | data = newData }
            in
                ( newModel, Cmd.none )

        LoadDataResult (Err e) ->
                let
                    _ =
                        log(toString e)
                 in
            ( model, Cmd.none )

        CategoryMsg msg ->
            let
                data =
                    model.data
                newData =
                    { data | categories =  categoryUpdate msg model.data.categories }
                newModel =
                    { model | data = newData }
            in
                ( newModel, Cmd.none )
