module Views.SearchResultsTabs exposing (searchResultsTabs)

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
import App.Types exposing (..)


tabOptions : List (Html msg)
tabOptions =
    [ Html.i [ class "fas fa-table" ] []
    , Html.i [ class "fas fa-map-marker-alt" ] []
    ]


renderTab : TabIndex -> (Int -> Html Msg -> Tab Msg)
renderTab activeTab index child =
    tab
        (activeTab == index)
        [ onClick <| ChangeTab index ]
        []
        [ child ]


renderTabs : Model -> List (Tab Msg)
renderTabs model =
    List.indexedMap (renderTab model.activeTab) tabOptions


tabMods : TabsModifiers
tabMods =
    TabsModifiers Boxed Left Large


searchResultsTabs : Model -> Html Msg
searchResultsTabs model =
    tabs
        tabMods
        []
        []
    <|
        renderTabs model
