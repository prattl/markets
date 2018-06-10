module App.Types exposing (..)

import Http


type ActiveResultsTab
    = ResultsTable
    | ResultsMap


type alias Model =
    { activeTab : ActiveResultsTab
    , loading : Bool
    , results : Maybe String
    , zipCode : String
    }


type Msg
    = ChangeTab ActiveResultsTab
    | ChangeZip String
    | SubmitSearch
    | ReceiveSearchResults (Result Http.Error String)
