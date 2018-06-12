module Views.SearchResults.Table exposing (searchResultsTable)

import App.Types exposing (..)
import Bulma.Elements exposing (..)
import Bulma.Modifiers exposing (..)
import Html exposing (Html)
import Html.Attributes exposing (class, href)


searchResultsRow : FarmersMarket -> TableRow Msg
searchResultsRow farmersMarket =
    tableRow
        False
        []
        [ tableCell [] [ Html.text farmersMarket.distance ]
        , tableCell [] [ Html.text farmersMarket.name ]
        , tableCell []
            [ Html.a [ href "" ]
                [ icon Small
                    []
                    [ Html.i [ class "fas fa-caret-right" ] [] ]
                , Html.text " More info"
                ]
            ]
        ]


searchResultsBody : Maybe (List FarmersMarket) -> TablePartition Msg
searchResultsBody results =
    tableBody [] <|
        case results of
            Just results ->
                (List.map searchResultsRow results)

            Nothing ->
                []


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
                [ tableCellHead [] [ Html.text "Distance (mi)" ]
                , tableCellHead [] [ Html.text "Name" ]
                , tableCellHead [] []
                ]
            ]
        , searchResultsBody model.results
        ]
