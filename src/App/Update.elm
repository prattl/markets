module App.Update exposing (update)

import App.Types exposing (..)
import Http
import Json.Decode exposing (..)


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
    FarmersMarket
        id_
        (let
            distance =
                List.head (String.split " " marketname)
         in
            case distance of
                Just dist ->
                    dist

                Nothing ->
                    ""
        )
        (String.join " " <|
            List.drop 1 <|
                String.split " " marketname
        )


responseToFarmersMarket : FarmersMarketResponse -> FarmersMarket
responseToFarmersMarket response =
    initFarmersMarket response.id response.name


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
            ( { model
                | loading = False
                , results =
                    Just
                        (List.map responseToFarmersMarket results)
              }
            , Cmd.none
            )

        ReceiveSearchResults (Err _) ->
            ( { model | loading = False, results = Just [] }, Cmd.none )
