module Views.SearchResults.Contents exposing (searchResultsContents)

import App.Types exposing (..)
import Html exposing (Html)
import Html.Attributes exposing (style)
import Views.SearchResults.Map exposing (searchResultsMap)
import Views.SearchResults.Table exposing (searchResultsTable)


renderTabContents : Model -> Html Msg
renderTabContents model =
    case model.activeTab of
        ResultsTable ->
            searchResultsTable model

        ResultsMap ->
            searchResultsMap model


searchResultsContents : Model -> Html Msg
searchResultsContents model =
    Html.section
        [ style [ ( "margin-top", "2rem" ) ] ]
        [ case model.results of
            Just _ ->
                renderTabContents model

            Nothing ->
                Html.text ""
        ]
