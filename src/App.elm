module Main exposing (..)

import Html exposing (Html)
import Html.Attributes
    exposing
        ( class
        , placeholder
        , style
        , type_
        )
import Html.Events exposing (onClick)
import Bulma.Modifiers exposing (..)
import Bulma.Components exposing (..)
import Bulma.Elements exposing (..)
import Bulma.Form exposing (..)
import Bulma.Layout exposing (..)


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = { zip = "", activeTab = 0 }
        , view = view
        , update = update
        }



-- MODEL


type alias TabIndex =
    Int


type alias Model =
    { zip : String
    , activeTab : TabIndex
    }



-- UPDATE


type Msg
    = ChangeTab TabIndex


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeTab newTab ->
            { model | activeTab = newTab }



-- VIEW


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


tabMods : TabsModifiers
tabMods =
    TabsModifiers Minimal Left Large


tabOptions : List (Html msg)
tabOptions =
    [ Html.i [ class "fas fa-table" ] []
    , Html.i [ class "fa fa-map-marker-alt" ] []
    ]


renderTab : TabIndex -> Int -> Html msg -> Html msg
renderTab activeTab index child =
    tab
        (activeTab == index)
        []
        []
        [ child ]


renderTabs : Model -> List (Tab msg)
renderTabs model =
    List.indexedMap (renderTab model.activeTab) tabOptions


resultsTabs : Model -> Html msg
resultsTabs model =
    tabs
        tabMods
        []
        []
    <|
        renderTabs model


appContainer : Model -> Html msg
appContainer model =
    section NotSpaced
        []
        [ container []
            [ searchForm
            , Html.div
                [ style [ ( "margin-top", "3rem" ) ] ]
                [ resultsTabs model ]
            ]
        ]


view : Model -> Html msg
view model =
    Html.main_ []
        [ marketsHero
        , appContainer model
        ]
