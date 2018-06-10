module Main exposing (..)

import Html exposing (Html)
import Html.Attributes
    exposing
        ( class
        , placeholder
        , style
        , type_
        )
import Bulma.Layout exposing (..)
import Layout.Header exposing (appHeader)
import Forms.ZipSearchForm exposing (zipSearchForm)
import App.Types exposing (..)
import App.Update exposing (update)
import Views.SearchResultsTabs exposing (searchResultsTabs)


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = { zip = "", activeTab = 0 }
        , view = view
        , update = update
        }


view : Model -> Html Msg
view model =
    Html.main_ []
        [ appHeader
        , zipSearchForm
        , container []
            [ Html.div
                []
                [ searchResultsTabs model ]
            , Html.div
                [ style [ ( "margin-top", "2rem" ) ] ]
                [ Html.text "Contents" ]
            ]
        ]
