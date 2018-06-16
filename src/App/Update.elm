module App.Update exposing (update)

import App.Types exposing (..)
import Http
import Json.Decode exposing (..)


updateFarmersMarketDetails : FarmersMarketID -> FarmersMarketDetails -> List FarmersMarket -> List FarmersMarket
updateFarmersMarketDetails farmersMarketIdToUpdate details list =
    let
        addDetails : FarmersMarket -> FarmersMarket
        addDetails farmersMarket =
            if farmersMarketIdToUpdate == farmersMarket.id then
                { farmersMarket | details = Just details }
            else
                farmersMarket
    in
        List.map addDetails list


toggleFarmersMarketExpanded : FarmersMarket -> List FarmersMarket -> List FarmersMarket
toggleFarmersMarketExpanded farmersMarket list =
    let
        toggle : FarmersMarket -> FarmersMarket
        toggle result =
            if farmersMarket.id == result.id then
                { result | expanded = not result.expanded }
            else
                { result | expanded = False }
    in
        List.map toggle list


decodeFarmersMarket : Decoder FarmersMarketResponse
decodeFarmersMarket =
    map2 FarmersMarketResponse
        (field "id" string)
        (field "marketname" string)


decodeDetails : Decoder FarmersMarketDetails
decodeDetails =
    map4 FarmersMarketDetails
        (field "Address" string)
        (field "GoogleLink" string)
        (field "Products" string)
        (field "Schedule" string)


decodeFarmersMarketResponse : Decoder ResponseResultsList
decodeFarmersMarketResponse =
    field "results" (list decodeFarmersMarket)


decodeDetailsResponse : Decoder FarmersMarketDetails
decodeDetailsResponse =
    field "marketdetails" decodeDetails


getFarmersMarketsByZip : String -> Cmd Msg
getFarmersMarketsByZip zipCode =
    let
        url =
            "https://search.ams.usda.gov/farmersmarkets/v1/data.svc/zipSearch?zip=" ++ zipCode

        request =
            Http.get url decodeFarmersMarketResponse
    in
        Http.send ReceiveSearchResults request


getFarmersMarketDetailsIfNeeded : FarmersMarket -> Cmd Msg
getFarmersMarketDetailsIfNeeded farmersMarket =
    let
        url =
            "https://search.ams.usda.gov/farmersmarkets/v1/data.svc/mktDetail?id=" ++ farmersMarket.id

        request =
            Http.get url decodeDetailsResponse
    in
        case farmersMarket.details of
            Just farmersMarketDetails ->
                Cmd.none

            Nothing ->
                Http.send (ReceiveDetails farmersMarket.id) request


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

        OpenMoreInfo farmersMarket ->
            let
                updatedResults =
                    case model.results of
                        Just results ->
                            Just <| toggleFarmersMarketExpanded farmersMarket results

                        Nothing ->
                            Nothing
            in
                ( { model | results = updatedResults }, getFarmersMarketDetailsIfNeeded farmersMarket )

        ReceiveDetails id_ (Ok detailResults) ->
            let
                updatedModel =
                    case model.results of
                        Just results ->
                            { model | results = Just <| updateFarmersMarketDetails id_ detailResults results }

                        Nothing ->
                            model
            in
                ( updatedModel, Cmd.none )

        ReceiveDetails id_ (Err _) ->
            ( model, Cmd.none )
