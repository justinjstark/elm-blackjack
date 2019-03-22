# Blackjack in Elm
Learning Elm by implementing blackjack (21)

## Running Tests
This project contains a Blackjack Elm module and a test project. To run the tests, simply run

```sh
npm install -g elm-test
elm-test
```

## Usage
Here's example usage from the REPL

```
> import Blackjack exposing (..)
> pointsForHand [Ten, Seven]
Hard 17 : HandPoint
> pointsForHand [Ace, Seven]
Soft 18 : HandPoint
> pointsForHand [Jack, Queen, King]
Bust: HandPoint
```

## How it works
Adding the points of two cards together works by generating the cartesian product of possible point values for each card and then adding all the pairs together. For example:

```
Hand = [Ace, Ace]
PointsPerCard = [[1, 11], [1, 11]]
PossiblePointValues = [2, 12, 12, 22]
```

For hands with more than two cards, we use the same algorithm with a fold. Then we remove any values greater than 21 and take the unique elements.

```
Hand = [Ace, Ace, Eight]
PointsPerCard = [[1, 11], [1, 11], [8]]
AfterFirstFoldStep = [[2, 12, 12, 22], [8]]
AfterFold = [10, 20, 20, 30]
ValidPointValues = [10, 20]
```

If there is more than one value in the list, the hand is soft. Finally, to get the hand value, we take the list of possible values and grab the maximum at most 21.

The algorithm, without any checking for a soft hand, is basically this:

```elm
hand
    |> List.map pointsForCard
    |> List.foldr addPointToList []
    |> List.filter (\n -> n <= 21)
    |> maximum
```

This algorithm is overkill but it allowed me to expand my functional programming skills. Plus you can change the card values and it will still work. For example, you can make another card contribute to a soft hand such as `Two -> [1, 2]`. Or you can give a card more than two values like `Ace -> [1, 5, 11]` and the point calculations will still work.
