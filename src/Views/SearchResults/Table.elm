module Views.SearchResults.Table exposing (searchResultsTable)

import App.Types exposing (..)
import Bulma.Elements exposing (..)
import Html exposing (Html)


searchResultsRow : FarmersMarket -> TableRow Msg
searchResultsRow farmersMarket =
    tableRow
        False
        []
        [ tableCell [] [ Html.text farmersMarket.id ]
        , tableCell [] [ Html.text farmersMarket.marketname ]
        ]


searchResultsBody : Maybe (List FarmersMarket) -> TablePartition Msg
searchResultsBody results =
    tableBody []
        (case results of
            Just results ->
                (List.map searchResultsRow results)

            Nothing ->
                []
        )


searchResultsTable : Model -> Html Msg
searchResultsTable model =
    table
        { tableModifiers | fullWidth = True }
        []
        [ tableHead
            []
            [ tableRow
                False
                []
                [ tableCellHead [] [ Html.text "ID" ]
                , tableCellHead [] [ Html.text "Name" ]
                ]
            ]
        , searchResultsBody model.results
        ]
