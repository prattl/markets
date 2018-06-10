module Forms.ZipSearchForm exposing (zipSearchForm)

import Html exposing (Html)
import Html.Attributes
    exposing
        ( class
        , placeholder
        , style
        , type_
        )
import Bulma.Modifiers exposing (..)
import Bulma.Form exposing (..)
import Bulma.Layout exposing (..)


searchInput : Html msg
searchInput =
    controlInput
        { controlInputModifiers
            | size = Large
            , iconRight = Just ( Large, [], Html.i [ class "fas fa-search" ] [] )
        }
        []
        [ placeholder "Zip code"
        , type_ "search"
        ]
        []


zipSearchForm : Html msg
zipSearchForm =
    section NotSpaced
        []
        [ container []
            [ Html.form []
                [ searchInput ]
            ]
        ]
