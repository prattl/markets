module Views.SearchResults.Table exposing (searchResultsTable)

import App.Types exposing (..)
import Bulma.Elements exposing (..)
import Bulma.Modifiers exposing (..)
import Html exposing (Html)
import Html.Attributes exposing (class, colspan, href)
import Html.Events exposing (onClick)


farmersMarketDetailsRow : FarmersMarket -> TableRow Msg
farmersMarketDetailsRow farmersMarket =
    case farmersMarket.expanded of
        True ->
            tableRow
                False
                []
                [ case farmersMarket.details of
                    Just details ->
                        tableCell [ colspan 3 ] [ Html.text "Details" ]

                    Nothing ->
                        icon Small
                            []
                            [ Html.i [ class "fas fa-sync fa-spin" ] [] ]
                ]

        False ->
            Html.text ""


searchResultsRow : Model -> FarmersMarket -> List (TableRow Msg)
searchResultsRow model farmersMarket =
    [ tableRow
        False
        []
        [ tableCell [] [ Html.text farmersMarket.distance ]
        , tableCell [] [ Html.text farmersMarket.name ]
        , tableCell []
            [ Html.a
                [ onClick <| SubmitMoreInfo farmersMarket ]
                [ icon Small
                    []
                    [ Html.i [ class "fas fa-caret-right" ] [] ]
                , Html.text " More info"
                ]
            ]
        ]
    , farmersMarketDetailsRow farmersMarket
    ]


searchResultsBody : Model -> TablePartition Msg
searchResultsBody model =
    tableBody [] <|
        case model.results of
            Just results ->
                List.foldr (++) [] <| List.map (searchResultsRow model) results

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
        , searchResultsBody model
        ]
