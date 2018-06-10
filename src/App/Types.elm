module App.Types exposing (..)

import Http


type ActiveResultsTab
    = ResultsTable
    | ResultsMap


type alias FarmersMarket =
    { id : String
    , marketname : String
    }


type alias ApiResponse =
    { result : List FarmersMarket }


type alias Model =
    { activeTab : ActiveResultsTab
    , loading : Bool
    , results : Maybe (List FarmersMarket)
    , zipCode : String
    }


type Msg
    = ChangeTab ActiveResultsTab
    | ChangeZip String
    | SubmitSearch
    | ReceiveSearchResults (Result Http.Error (List FarmersMarket))
