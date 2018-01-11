module Main.Update exposing (..)

import Http
import Main.Models exposing (..)
import Categories.Update as Categories exposing (categoryUpdate)
import Debug exposing (log)
import Dict


type Msg
    = CategoryMsg Categories.Msg
    | ToggleSideBar
    | LoadData
    | LoadDataResult (Result Http.Error ResponseData)
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

        LoadDataResult (Ok { data }) ->
            let
                modelData =
                    model.data

                newData =
                    { categories = data.categories
                    , descriptions = data.descriptions
                    , technologies = Dict.fromList (List.map (\i -> ( i.id, i )) data.technologies)
                    }

                newModel =
                    { model | data = newData }
            in
                ( newModel, Cmd.none )

        LoadDataResult (Err e) ->
            let
                _ =
                    log "ERROR" (toString e)
            in
                ( model, Cmd.none )

        CategoryMsg msg ->
            let
                data =
                    model.data

                newData =
                    { data | categories = categoryUpdate msg model.data.categories }

                newModel =
                    { model | data = newData }
            in
                ( newModel, Cmd.none )
