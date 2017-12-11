module Main.Request exposing (..)
import Http
import Json.Decode as Decode exposing (..)
import Json.Decode.Extra exposing (..)
import Json.Encode as Encode
import Main.Models exposing (Description, DescriptionsData, Descriptions)
import Main.Update exposing (..)

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

loadData : Cmd Msg
loadData =
    let
        request =
            Http.post graphQLApiUrl (generateQuery descriptionsQuery) decodeDescription
    in
        Http.send LoadDataResult request
