module App.Types exposing (..)


type alias TabIndex =
    Int


type alias Model =
    { zip : String
    , activeTab : TabIndex
    }


type Msg
    = ChangeTab TabIndex
