module App.Update exposing (update)

import App.Types exposing (..)


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeTab newTab ->
            { model | activeTab = newTab }
