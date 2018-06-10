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
import Html.Events exposing (onInput, onSubmit)
import Bulma.Elements exposing (..)
import Bulma.Modifiers exposing (..)
import Bulma.Form exposing (..)
import Bulma.Layout exposing (..)


baseModifiers : ButtonModifiers msg
baseModifiers =
    { buttonModifiers
        | size = Large
        , color = Info
    }


searchButtonModifiers : Model -> ButtonModifiers msg
searchButtonModifiers { loading } =
    if loading then
        { baseModifiers | state = Loading }
    else
        baseModifiers


searchButton : Model -> Control Msg
searchButton model =
    controlButton
        (searchButtonModifiers model)
        []
        [ type_ "submit" ]
        [ icon Medium
            []
            [ Html.i [ class "fas fa-search" ] [] ]
        , Html.text " "
        , Html.text "Search"
        ]


searchInput : Model -> Control Msg
searchInput model =
    connectedFields Centered
        []
        [ controlInput
            { controlInputModifiers | size = Large }
            []
            [ onInput ChangeZip
            , placeholder "Zip code"
            , type_ "search"
            ]
            []
        , searchButton model
        ]


zipSearchForm : Model -> Html Msg
zipSearchForm model =
    section NotSpaced
        []
        [ container []
            [ Html.form
                [ onSubmit SubmitSearch ]
                [ searchInput model ]
            ]
        ]
