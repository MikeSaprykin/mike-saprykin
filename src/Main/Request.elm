module Main.Request exposing (..)
import Http
import Json.Decode as Decode exposing (..)
import Json.Decode.Extra exposing (..)
import Main.Models exposing (Description, DescriptionsData, Descriptions)
import Main.Update exposing (..)
import Utils exposing (..)

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


descriptionsQuery : Http.Body
descriptionsQuery =
    graphQLBodyWithoutVariables """
        {
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
            categories {
                _id
                title
            }
        }
    """

descriptionsRequest : Http.Request Descriptions
descriptionsRequest =
    graphQLRequest descriptionsQuery decodeDescription

loadData : Cmd Msg
loadData =
    Http.send LoadDataResult descriptionsRequest

