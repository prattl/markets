module Main exposing (..)

import Html
    exposing
        ( Html
        , Attribute
        , article
        , button
        , div
        , footer
        , header
        , h1
        , main_
        , section
        , text
        )
import Html.Attributes exposing (..)


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }



-- MODEL


type alias Model =
    Int


model : Model
model =
    0



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model



-- VIEW


headerStyle : Attribute msg
headerStyle =
    style
        [ ( "borderBottom", "2px solid #DDD" )
        , ( "height", "3rem" )
        ]




view : Model -> Html Msg
view model =
    div []
        [ header [ headerStyle ]
            [ h1 [] [ text "Find a Farmer's Market" ] ]
        , main_ [] []
        , footer [] []
        ]
