module Main.Request exposing (..)

import Http
import Json.Decode as Decode exposing (..)
import Json.Decode.Extra exposing (..)
import Main.Models exposing (ModelData)
import Main.Update exposing (..)
import Utils exposing (..)
import Categories.Request exposing (..)
import Descriptions.Models exposing (..)

rootDecoder : Decoder ModelData
rootDecoder =
    map2 ModelData
        ( field "descriptions" decodeDescription)
        (field "categories" categoriesDecoder)

decodeDescription : Decoder Descriptions
decodeDescription =
    map Descriptions
       (field "data" decodeDescriptionData)


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
