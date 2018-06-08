module Layout.Header exposing (..)

import Html
    exposing
        ( Html
        , Attribute
        , article
        , button
        , div
        , footer
        , header
        , h1
        , main_
        , section
        , text
        )
import Html.Attributes exposing (..)


headerStyle : Attribute msg
headerStyle =
    style
        [ ( "border-bottom", "2px solid #DDD" )
        , ( "padding", "0.75em" )
        ]


navHeader : Html msg
navHeader =
    header [ headerStyle ]
        [ h1
            [ style
                [ ( "margin", "0" )
                ]
            ]
            [ text "Find a Farmer's Market" ]
        ]
