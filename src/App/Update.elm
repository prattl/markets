module App.Update exposing (update)

import App.Types exposing (..)
import Http
import Json.Decode exposing (..)


decodeFarmersMarket : Decoder FarmersMarket
decodeFarmersMarket =
    map2 FarmersMarket
        (field "id" string)
        (field "marketname" string)


decodeResponse : Decoder (List FarmersMarket)
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
            ( { model | loading = False, results = Just results }, Cmd.none )

        ReceiveSearchResults (Err _) ->
            ( { model | loading = False, results = Just [] }, Cmd.none )
