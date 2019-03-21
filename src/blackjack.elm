module Blackjack exposing (Rank(..), Card, Hand, HandPoint(..), pointsForHand)

import List.Extra

--type Suit = Clubs | Diamonds | Hearts | Spades
type Rank = Two | Three | Four | Five | Six | Seven | Eight | Nine | Ten | Jack | Queen | King | Ace

type alias Card = { rank: Rank }

type alias Hand = List Card

type CardPoint = Hard Int | Soft (List Int)

type HandPoint = InPlay Int | Bust

pointsForCard : Card -> CardPoint
pointsForCard card =
  case card.rank of
    Two -> Hard 2
    Three -> Hard 3
    Four -> Hard 4
    Five -> Hard 5
    Six -> Hard 6
    Seven -> Hard 7
    Eight -> Hard 8
    Nine -> Hard 9
    Ten -> Hard 10
    Jack -> Hard 10
    Queen -> Hard 10
    King -> Hard 10
    Ace -> Soft [1, 11]

getPointValuesAsList: CardPoint -> List Int
getPointValuesAsList cardPoint =
  case cardPoint of
    Hard x -> [x]
    Soft x -> x

addPointToList: CardPoint -> List Int -> List Int
addPointToList cardPoint valueList =
  let valueListForCard = getPointValuesAsList cardPoint
  in case valueList of
    [] -> valueListForCard
    _ -> valueList
      |> List.concatMap (\x -> List.map (\y -> x + y) valueListForCard)
      |> List.Extra.unique
      |> List.sort

{-| Get the maximum point value of a hand.

  pointsForHand [Card Ace, Card Ten] == InPlay 21
  pointsForHand [Card Ten, Card Jack, Card Queen] == Bust
-}
pointsForHand : Hand -> HandPoint
pointsForHand hand =
  let
    value =
      hand
      |> List.map pointsForCard
      |> List.foldr addPointToList [0]
      |> List.filter (\n -> n <= 21)
      |> List.maximum
  in case value of
    Just n -> InPlay n
    Nothing -> Bust
