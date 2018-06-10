module Forms.ZipSearchForm exposing (zipSearchForm)

import App.Types exposing (..)
import Html exposing (Html)
import Html.Attributes
    exposing
        ( class
        , placeholder
        , style
        , type_
        )
import Html.Events exposing (onInput)
import Bulma.Modifiers exposing (..)
import Bulma.Form exposing (..)
import Bulma.Layout exposing (..)


searchInput : Control Msg
searchInput =
    controlInput
        { controlInputModifiers
            | size = Large
            , iconRight = Just ( Large, [], Html.i [ class "fas fa-search" ] [] )
        }
        []
        [ onInput ChangeZip
        , placeholder "Zip code"
        , type_ "search"
        ]
        []


zipSearchForm : Model -> Html Msg
zipSearchForm model =
    section NotSpaced
        []
        [ container []
            [ Html.form []
                [ searchInput ]
            ]
        ]
