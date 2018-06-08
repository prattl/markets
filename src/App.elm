module Main exposing (..)

import Html
    exposing
        ( Html
        , Attribute
        , article
        , button
        , div
        , form
        , header
        , i
        , h1
        , main_
        , p
        , text
        )
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
    {}


main : Program Never Model msg
main =
    Html.beginnerProgram
        { model = {}
        , view = view
        , update = \msg -> \model -> model
        }


marketsHero : Html msg
marketsHero =
    hero { heroModifiers | size = Small, color = Primary }
        []
        [ heroBody []
            [ container []
                [ title H1 [] [ text "Find a Farmer's Market" ]
                , subtitle H2 [] [ text "Lorem Ipsum" ]
                ]
            ]
        ]


searchInputModifiers : ControlInputModifiers msg
searchInputModifiers =
    { controlInputModifiers
        | size = Large
        , iconRight = Just ( Large, [], i [ class "fas fa-search" ] [] )
    }


searchInput : Html msg
searchInput =
    let
        searchControlAttrs : List (Attribute msg)
        searchControlAttrs =
            []

        searchInputAttrs : List (Attribute msg)
        searchInputAttrs =
            [ placeholder "Zip code"
            , type_ "search"
            ]
    in
        controlInput
            searchInputModifiers
            searchControlAttrs
            searchInputAttrs
            []


searchForm : Html msg
searchForm =
    form []
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
    main_ []
        [ marketsHero
        , appContainer
        ]
