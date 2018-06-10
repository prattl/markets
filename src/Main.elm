module Main exposing (..)

import Html exposing (Html)
import Bulma.Layout exposing (..)
import Layout.Header exposing (appHeader)
import Forms.ZipSearchForm exposing (zipSearchForm)
import App.Types exposing (..)
import App.Update exposing (update)
import Views.SearchResults.Contents exposing (searchResultsContents)
import Views.SearchResults.Tabs exposing (searchResultsTabs)


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = { zip = "", activeTab = ResultsTable }
        , view = view
        , update = update
        }


view : Model -> Html Msg
view model =
    Html.main_ []
        [ appHeader
        , zipSearchForm
        , container []
            [ searchResultsTabs model
            , searchResultsContents model
            ]
        ]
