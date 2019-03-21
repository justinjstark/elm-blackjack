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
