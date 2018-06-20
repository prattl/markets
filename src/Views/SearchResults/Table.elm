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
        , target
        )
import Html.Events exposing (onClick)


googleLink : String -> Html Msg
googleLink to =
    Html.a
        [ href to
        , target "_blank"
        ]
        [ Html.text "Google Maps link "
        , icon Small
            []
            [ Html.i [ class "fas fa-external-link-alt" ] [] ]
        ]


farmersMarketDetails : FarmersMarketDetails -> Html Msg
farmersMarketDetails details =
    Html.div [ class "content" ]
        [ Html.ul []
            [ Html.li []
                [ Html.text details.address
                , Html.text " ("
                , googleLink details.googleLink
                , Html.text ")"
                ]
            , Html.li []
                [ Html.text <| "Products: " ++ details.product
                ]
            , Html.li [] [ Html.text <| "Schedule: " ++ details.schedule ]
            ]
        ]


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
                        tableCell [ colspan 3 ] [ farmersMarketDetails details ]

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
