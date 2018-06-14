module Views.SearchResults.Table exposing (searchResultsTable)

import App.Types exposing (..)
import Bulma.Elements exposing (..)
import Bulma.Modifiers exposing (..)
import Html exposing (Html)
import Html.Attributes
    exposing
        ( class
        , colspan
        , href
        , style
        )
import Html.Events exposing (onClick)


moreInfoButton : FarmersMarket -> Html Msg
moreInfoButton farmersMarket =
    let
        iconClass : String
        iconClass =
            case farmersMarket.expanded of
                True ->
                    "fas fa-caret-down"

                False ->
                    "fas fa-caret-right"
    in
        Html.a
            [ onClick <| OpenMoreInfo farmersMarket ]
            [ icon Small
                []
                [ Html.i [ class iconClass ] [] ]
            , Html.text " More info"
            ]


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
                        tableCell
                            [ class "has-text-centered"
                            , colspan 3
                            ]
                            [ icon Medium
                                [ style [ ( "margin", "2rem 0" ) ] ]
                                [ Html.i [ class "fas fa-sync fa-spin fa-lg" ] [] ]
                            ]
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
        , tableCell [] [ moreInfoButton farmersMarket ]
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
