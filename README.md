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

Adding the points of two cards together works by generating the cartesian product of possible point values for each card and then adding all the pairs together. For example:

```
Hand = [Card Ace, Card Ace]
PointsPerCard = [[1, 11], [1, 11]]
PossiblePointValues = [2, 12, 12, 22]
```

For hands with more than two cards, we use the same algorithm with a fold. Finally, to get the hand value, we take the list of possible values and grab the maximum at most 21. Example:

```
Hand = [Card Ace, Card Ace, Card Eight]
PointsPerCard = [[1, 11], [1, 11], [8]]
AfterFirstFoldStep = [[2, 12, 12, 22], [8]]
PossiblePointValues = [10, 20, 20, 30]
FinalPointValue = 20
```

Here's the exact algorithm:

```elm
hand
    |> List.map pointsForCard
    |> List.foldr addPointToList []
    |> List.filter (\n -> n <= 21)
    |> List.maximum
```

This algorithm is overkill but it allowed me to expand my functional programming skills. Plus you can change the card values and it will still work. For example, you can make another card soft such as `Two -> Soft [1, 2]`. Or you can give a card more than two soft values like `Ace -> Soft [1, 5, 11]` and the point calculations will still work.

I realize I could have just used lists of possible card values rather than creating a CardPoint type, but using Hard and Soft injects some domain language into code and also served to make me more comfortable with Elm's pattern matching.
