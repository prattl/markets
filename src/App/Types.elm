module App.Types exposing (..)


type ActiveResultsTab
    = ResultsTable
    | ResultsMap


type alias Model =
    { activeTab : ActiveResultsTab
    , loading : Bool
    , results : Maybe (List String)
    , zipCode : String
    }


type Msg
    = ChangeTab ActiveResultsTab
    | ChangeZip String
