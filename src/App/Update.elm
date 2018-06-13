module App.Update exposing (update)

import App.Types exposing (..)
import Http
import Json.Decode exposing (..)


updateFarmersMarket : FarmersMarket -> List FarmersMarket -> List FarmersMarket
updateFarmersMarket farmersMarket list =
    let
        toggle : FarmersMarket -> FarmersMarket
        toggle result =
            if farmersMarket.id == result.id then
                { result | expanded = True }
            else
                { result | expanded = False }
    in
        List.map toggle list


decodeFarmersMarket : Decoder FarmersMarketResponse
decodeFarmersMarket =
    map2 FarmersMarketResponse
        (field "id" string)
        (field "marketname" string)


decodeResponse : Decoder ResponseResultsList
decodeResponse =
    field "results" (list decodeFarmersMarket)


getFarmersMarketsByZip : String -> Cmd Msg
getFarmersMarketsByZip zipCode =
    let
        url =
            "https://search.ams.usda.gov/farmersmarkets/v1/data.svc/zipSearch?zip=" ++ zipCode

        request =
            Http.get url decodeResponse
    in
        Http.send ReceiveSearchResults request


initFarmersMarket : String -> String -> FarmersMarket
initFarmersMarket id_ marketname =
    let
        distance =
            let
                dist_ =
                    List.head (String.split " " marketname)
            in
                case dist_ of
                    Just dist_ ->
                        dist_

                    Nothing ->
                        ""

        name =
            String.join " " <|
                List.drop 1 <|
                    String.split " " marketname
    in
        FarmersMarket
            id_
            distance
            name
            Nothing
            False


responseToFarmersMarket : FarmersMarketResponse -> FarmersMarket
responseToFarmersMarket response =
    initFarmersMarket response.id response.name


calculateError : ResultsList -> Bool
calculateError results =
    let
        result =
            List.head results
    in
        case result of
            Just r ->
                r.id == "Error"

            Nothing ->
                False


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeTab newTab ->
            ( { model | activeTab = newTab }, Cmd.none )

        ChangeZip newZip ->
            ( { model | zipCode = newZip }, Cmd.none )

        SubmitSearch ->
            ( { model | loading = True }, getFarmersMarketsByZip model.zipCode )

        ReceiveSearchResults (Ok results) ->
            ( let
                resultsList =
                    List.map responseToFarmersMarket results
              in
                { model
                    | error = calculateError resultsList
                    , loading = False
                    , results = Just resultsList
                }
            , Cmd.none
            )

        ReceiveSearchResults (Err _) ->
            ( { model | loading = False, results = Just [] }, Cmd.none )

        SubmitMoreInfo farmersMarket ->
            let
                updatedResults =
                    case model.results of
                        Just results ->
                            Just <| updateFarmersMarket farmersMarket results

                        Nothing ->
                            Nothing
            in
                ( { model | results = updatedResults }, Cmd.none )

        ReceiveMoreInfo (Ok results) ->
            ( model, Cmd.none )

        ReceiveMoreInfo (Err _) ->
            ( model, Cmd.none )
