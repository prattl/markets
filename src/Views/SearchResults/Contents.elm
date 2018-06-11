module Views.SearchResults.Contents exposing (searchResultsContents)

import App.Types exposing (..)
import Bulma.Columns exposing (..)
import Bulma.Elements exposing (..)
import Bulma.Modifiers exposing (..)
import Html exposing (Html)
import Html.Attributes exposing (class, style)
import Views.SearchResults.Map exposing (searchResultsMap)
import Views.SearchResults.Table exposing (searchResultsTable)


renderTabContents : Model -> Html Msg
renderTabContents model =
    case model.activeTab of
        ResultsTable ->
            searchResultsTable model

        ResultsMap ->
            searchResultsMap model


errorMessage : Html Msg
errorMessage =
    columns
        { columnsModifiers | centered = True }
        []
        [ column
            columnModifiers
            [ class "is-half is-narrow" ]
            [ notification
                Danger
                []
                [ Html.text "No results were found. Try a different ZIP code." ]
            ]
        ]


searchResultsContents : Model -> Html Msg
searchResultsContents model =
    Html.section
        [ style [ ( "margin-top", "2rem" ) ] ]
        [ case model.error of
            True ->
                errorMessage

            False ->
                (case model.results of
                    Just _ ->
                        renderTabContents model

                    Nothing ->
                        Html.text ""
                )
        ]
