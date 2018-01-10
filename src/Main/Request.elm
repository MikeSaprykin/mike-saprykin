module Main.Request exposing (..)

import Http
import Json.Decode as Decode exposing (..)
import Json.Decode.Extra exposing (..)
import Main.Models exposing (ModelData, Data)
import Main.Update exposing (..)
import Utils exposing (..)
import Categories.Request exposing (..)
import Descriptions.Models exposing (..)

rootDecoder : Decoder ModelData
rootDecoder =
    succeed ModelData
        |: (field "data" decodeData)

decodeData : Decoder Data
decodeData =
    map2 Data
        (field "descriptions" (list decodeDescriptionItem))
        (field "categories" categoriesDecoder)


decodeDescriptionItem : Decode.Decoder Description
decodeDescriptionItem =
    map4 Description
        (field "icon" string)
        (field "title" string)
        (field "description" string)
        (field "_id" string)


rootQuery : String
rootQuery =
    """
        {
    """
        ++ """
        descriptions {
              title
              _id
              description
              icon
            }
            technologies {
                _id
                title
            }
    """
        ++ categoriesQuery
        ++ """
        }
    """


rootRequest : Http.Request ModelData
rootRequest =
    graphQLRequest (graphQLBodyWithoutVariables rootQuery) rootDecoder


loadData : Cmd Msg
loadData =
    Http.send LoadDataResult rootRequest


rootGraphQLRequest : Cmd Msg
rootGraphQLRequest =
    Http.send LoadDataResult rootRequest
