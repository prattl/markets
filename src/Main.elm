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
    Html.program
        { init = init
        , view = view
        , subscriptions = subscriptions
        , update = update
        }


model : Model
model =
    Model ResultsTable False False Nothing ""


init : ( Model, Cmd Msg )
init =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    Html.main_ []
        [ appHeader
        , zipSearchForm model
        , container []
            [ searchResultsTabs model
            , searchResultsContents model
            ]
        ]
