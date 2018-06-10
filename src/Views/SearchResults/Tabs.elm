module Views.SearchResults.Tabs exposing (searchResultsTabs)

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


type alias TabOption =
    { node : Html Msg
    , tabContent : ActiveResultsTab
    }


tabOptions : List TabOption
tabOptions =
    [ TabOption
        (Html.i
            [ class "fas fa-table" ]
            []
        )
        ResultsTable
    , TabOption
        (Html.i
            [ class "fas fa-map-marker-alt" ]
            []
        )
        ResultsMap
    ]


renderTab : ActiveResultsTab -> (TabOption -> Tab Msg)
renderTab activeTab tabOption =
    tab
        (activeTab == tabOption.tabContent)
        [ onClick <| ChangeTab tabOption.tabContent ]
        []
        [ tabOption.node ]


renderTabs : Model -> List (Tab Msg)
renderTabs model =
    List.map (renderTab model.activeTab) tabOptions


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
