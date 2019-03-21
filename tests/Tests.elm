module Tests exposing (..)

import Expect exposing (Expectation)
import Test exposing (..)
import Blackjack exposing (..)

pointsForHandTest : Test
pointsForHandTest =
    describe "pointsForHand"
        [ test "1 Ace" <|
            \_ ->
                Expect.equal (pointsForHand [Card Ace]) (InPlay 11)
        , test "1 Jack" <|
            \_ ->
                Expect.equal (pointsForHand [Card Jack]) (InPlay 10)
        , test "1 Ace and 1 Jack" <|
            \_ ->
                Expect.equal (pointsForHand [Card Ace, Card Jack]) (InPlay 21)
        , test "2 Aces" <|
            \_ ->
                Expect.equal (pointsForHand [Card Ace, Card Ace]) (InPlay 12)
        , test "3 Aces" <|
            \_ ->
                Expect.equal (pointsForHand [Card Ace, Card Ace, Card Ace]) (InPlay 13)
        , test "1 Jack, 1 Queen, 1 King" <|
            \_ ->
                Expect.equal (pointsForHand [Card Jack, Card Queen, Card King]) (Bust)
        , test "2 Aces, 1 Ten" <|
            \_ ->
                Expect.equal (pointsForHand [Card Ace, Card Ten, Card Ace]) (InPlay 12)
        , test "1 Six, 1 Seven, 1 Eight" <|
            \_ ->
                Expect.equal (pointsForHand [Card Six, Card Seven, Card Eight]) (InPlay 21)
        , test "1 Seven, 1 Eight, 1 Nine" <|
            \_ ->
                Expect.equal (pointsForHand [Card Seven, Card Eight, Card Nine]) (Bust)
        ]
        