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
> pointsForHand [Card Ace, Card Seven]
InPlay 18 : HandPoint
> pointsForHand [Card Jack, Card Queen, Card King]
Bust: HandPoint
```

## How it works
I stole the idea of creating this from [Cameron Pressley's F# Blackjack](https://github.com/cameronpresley/Blackjack) and similarly use Hard and Soft type constructors to represent card points.

Adding the points of two cards together works by generating the cartesian product of possible point values for each card and then adding all the pairs together. Then we remove duplicates and remove any value above 21. For example:

```
Hand = [Card Ace, Card Ace]
PointsPerCard = [[1, 11], [1, 11]]
PossiblePointValues = [2, 12, 12, 22]
FinalPointValues = [2, 12]
```

For hands with more than two cards, we use the same algorithm with a fold followed by taking the maximum value at most 21. Example:

```
Hand = [Card Ace, Card Ace, Card Eight]
PointsPerCard = [[1, 11], [1, 11], [8]]
AfterFirstFoldStep = [[2, 12], [8]]
PossiblePointValues = [10, 20]
FinalPointValue = 20
```

This algorithm is overkill but it allowed me to expand my functional programming skills. Plus you can change the card values and it will still work. For example, you can make another card soft such as `Two -> Soft [1, 2]`. Or you can give a card more than two soft values like `Ace -> Soft [1, 5, 11]` and the point calculations will still work.
