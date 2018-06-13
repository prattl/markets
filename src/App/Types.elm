module App.Types exposing (..)

import Http


type ActiveResultsTab
    = ResultsTable
    | ResultsMap


type alias FarmersMarketResponse =
    { id : String
    , name : String
    }


type alias ResponseResultsList =
    List FarmersMarketResponse


type alias FarmersMarketDetails =
    { address : String
    , googleLink : String
    , product : String
    , schedule : String
    }


type alias FarmersMarket =
    { id : String
    , distance : String
    , name : String
    , details : Maybe FarmersMarketDetails
    , expanded : Bool
    }


type alias ResultsList =
    List FarmersMarket


type alias Model =
    { activeTab : ActiveResultsTab
    , error : Bool
    , loading : Bool
    , results : Maybe ResultsList
    , zipCode : String
    }


type Msg
    = ChangeTab ActiveResultsTab
    | ChangeZip String
    | SubmitSearch
    | ReceiveSearchResults (Result Http.Error ResponseResultsList)
    | SubmitMoreInfo FarmersMarket
    | ReceiveMoreInfo (Result Http.Error FarmersMarketDetails)
