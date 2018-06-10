module App.Types exposing (..)


type ActiveResultsTab
    = ResultsTable
    | ResultsMap


type alias Model =
    { zip : String
    , activeTab : ActiveResultsTab
    }


type Msg
    = ChangeTab ActiveResultsTab
