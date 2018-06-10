module App.Update exposing (update)

import App.Types exposing (..)


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeTab newTab ->
            { model | activeTab = newTab }

        ChangeZip newZip ->
            { model | zipCode = newZip }

        SubmitSearch ->
            { model | loading = True }

        ReceiveSearchResults (Ok results) ->
            { model | loading = False, results = Just results }

        ReceiveSearchResults (Err _) ->
            { model | loading = False, results = Just "" }
