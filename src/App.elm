module Main exposing (..)

import Html exposing (Html)
import Html.Attributes
    exposing
        ( class
        , placeholder
        , type_
        )
import Bulma.Modifiers exposing (..)
import Bulma.Elements exposing (..)
import Bulma.Form exposing (..)
import Bulma.Layout exposing (..)


type alias Model =
    { zip : String }


main : Program Never Model msg
main =
    Html.beginnerProgram
        { model = { zip = "" }
        , view = view
        , update = \msg -> \model -> model
        }


marketsHero : Html msg
marketsHero =
    hero { heroModifiers | size = Small, color = Primary }
        []
        [ heroBody []
            [ container []
                [ title H1 [] [ Html.text "Find a Farmer's Market" ]
                , subtitle H2 [] [ Html.text "Lorem Ipsum" ]
                ]
            ]
        ]


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


searchForm : Html msg
searchForm =
    Html.form []
        [ searchInput ]


appContainer : Html msg
appContainer =
    section NotSpaced
        []
        [ container []
            [ searchForm ]
        ]


view : Model -> Html msg
view model =
    Html.main_ []
        [ marketsHero
        , appContainer
        ]
