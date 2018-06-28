module Main where

import Prelude

import Effect (Effect)
import Spork.Html (Html)
import Spork.Html as H
import Spork.PureApp (PureApp)
import Spork.PureApp as PureApp

type State =
  Int

data Action =
    Increment
  | Decrement

update :: State -> Action -> State
update s a =
  case a of
    Increment ->
      s + 1
    Decrement ->
      s - 1

render :: State -> Html Action
render s =
  H.div
    []
    [ H.button
        [ H.onClick (H.always_ Decrement) ]
        [ H.text "-" ]
    , H.button
        [ H.onClick (H.always_ Increment) ]
        [ H.text "+" ]
    , H.span
        []
        [ H.text (show s) ]
    ]

defaultState :: State
defaultState =
  0

app :: PureApp State Action
app =
  { update
  , render
  , init: defaultState }

main :: Effect Unit
main =
  void $ PureApp.makeWithSelector app "#app"
