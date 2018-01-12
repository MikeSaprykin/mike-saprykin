module Main.Request exposing (..)

import Http
import Json.Decode as Decode exposing (..)
import Json.Decode.Extra exposing (..)
import Main.Models exposing (ModelData, Data, ResponseData)
import Main.Update exposing (..)
import Utils exposing (..)
import Categories.Request exposing (..)
import Descriptions.Models exposing (..)
import Technologies.Models exposing (Technology, TechnologyDetail)

rootDecoder : Decoder ResponseData
rootDecoder =
    succeed ResponseData
        |: (field "data" decodeData)

decodeData : Decoder Data
decodeData =
    map3 Data
        (field "descriptions" (list decodeDescriptionItem))
        (field "categories" categoriesDecoder)
        (field "technologies" (list decodeTechnology))


decodeTechnology : Decode.Decoder Technology
decodeTechnology =
    map4 Technology
        (field "_id" string)
        (field "icon" string)
        (field "title" string)
        (field "description" (maybe decodeTechnologyDescription))


decodeTechnologyDescription : Decode.Decoder TechnologyDetail
decodeTechnologyDescription =
    map3 TechnologyDetail
        (field "description" string)
        (field "level" string)
        (field "projects" string)


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
              _id
              title
              description
              icon
            }
            technologies {
                _id
                title
                icon
                description
            }
    """
        ++ categoriesQuery
        ++ """
        }
    """


rootRequest : Http.Request ResponseData
rootRequest =
    graphQLRequest (graphQLBodyWithoutVariables rootQuery) rootDecoder


loadData : Cmd Msg
loadData =
    Http.send LoadDataResult rootRequest


rootGraphQLRequest : Cmd Msg
rootGraphQLRequest =
    Http.send LoadDataResult rootRequest
