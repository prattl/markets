module Layout.Header exposing (appHeader)

import Html exposing (Html)
import Html.Attributes
    exposing
        ( class
        , placeholder
        , style
        , type_
        )
import Bulma.Modifiers exposing (..)
import Bulma.Elements exposing (..)
import Bulma.Layout exposing (..)


marketsHero : Html msg
marketsHero =
    hero { heroModifiers | size = Small, color = Primary }
        []
        [ heroBody []
            [ container []
                [ title H1 [] [ Html.text "Farmer's Market Locator" ]
                , subtitle H2
                    []
                    [ Html.span []
                        [ Html.text "Find a Farmer's Market Near You "
                        , icon Medium
                            [ class "has-text-warning" ]
                            [ Html.i [ class "fas fa-map-marker-alt" ] [] ]
                        ]
                    ]
                ]
            ]
        ]


appHeader : Html msg
appHeader =
    marketsHero
