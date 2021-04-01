module Blackjack exposing (Card(..), Hand, HandPoint(..), pointsForHand)

import List.Extra

type Card = Two | Three | Four | Five | Six | Seven | Eight | Nine | Ten | Jack | Queen | King | Ace

type alias Hand = List Card

type HandPoint = Hard Int | Soft Int | Bust

pointsForCard : Card -> List Int
pointsForCard card =
  case card of
    Two -> [2]
    Three -> [3]
    Four -> [4]
    Five -> [5]
    Six -> [6]
    Seven -> [7]
    Eight -> [8]
    Nine -> [9]
    Ten -> [10]
    Jack -> [10]
    Queen -> [10]
    King -> [10]
    Ace -> [1, 11]

addPointsToList: List Int -> List Int -> List Int
addPointsToList points list =
  case list of
    [] -> points
    ps -> ps
      |> List.concatMap (\x -> List.map (\y -> x + y) points)

descending a b =
  case compare a b of
    LT -> GT
    EQ -> EQ
    GT -> LT

getValidHandValues : Hand -> List Int
getValidHandValues hand =
  hand
    |> List.map pointsForCard
    |> List.foldr addPointsToList [0]
    |> List.filter (\n -> n <= 21)
    |> List.Extra.unique

{-| Get the best point value of a hand.
  pointsForHand [Card Ace, Card Ten] == Soft 21
  pointsForHand [Card Ten, Card Jack, Card Queen] == Bust
-}
pointsForHand : Hand -> HandPoint
pointsForHand hand =
  case hand of
    [] -> Hard 0
    h ->
      case (h |> getValidHandValues |> List.sortWith descending) of
        [] -> Bust
        [n] -> Hard n
        n :: ns -> Soft n
