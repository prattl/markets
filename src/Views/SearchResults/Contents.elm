module Views.SearchResults.Contents exposing (searchResultsContents)

import App.Types exposing (..)
import Html exposing (Html)
import Views.SearchResults.Map exposing (searchResultsMap)
import Views.SearchResults.Table exposing (searchResultsTable)


searchResultsContents : Model -> Html Msg
searchResultsContents model =
    case model.activeTab of
        ResultsTable ->
            searchResultsTable model

        ResultsMap ->
            searchResultsMap model
