module Utils exposing (..)

import Json.Encode as Encode exposing (..)
import Json.Decode exposing (Decoder)
import Http exposing (jsonBody, Body, post, Request, Error)
import Html exposing (text)


noElement =
    text ""


graphQLApiUrl : String
graphQLApiUrl =
    "http://localhost:8080/graphql"


graphQLBody : String -> List ( String, Value ) -> Body
graphQLBody query variables =
    jsonBody
        (object
            [ ( "query", string <| query )
            , ( "operationName", string <| "" )
            , ( "variables", object variables )
            ]
        )


graphQLBodyWithoutVariables : String -> Body
graphQLBodyWithoutVariables query =
    graphQLBody query [ ( "", string <| "" ) ]


graphQLRequest : Body -> Decoder a -> Request a
graphQLRequest body decoder =
    post graphQLApiUrl body decoder
