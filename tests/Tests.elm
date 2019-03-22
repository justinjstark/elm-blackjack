module Tests exposing (..)

import Expect exposing (Expectation)
import Test exposing (..)
import Blackjack exposing (..)

pointsForHandTest : Test
pointsForHandTest =
    describe "pointsForHand"
        [ test "Empty hand" <|
            \_ ->
                Expect.equal (pointsForHand []) (Hard 0)
        , test "1 Ace" <|
            \_ ->
                Expect.equal (pointsForHand [Ace]) (Soft 11)
        , test "1 Jack" <|
            \_ ->
                Expect.equal (pointsForHand [Jack]) (Hard 10)
        , test "1 Ace and 1 Jack" <|
            \_ ->
                Expect.equal (pointsForHand [Ace, Jack]) (Soft 21)
        , test "2 Aces" <|
            \_ ->
                Expect.equal (pointsForHand [Ace, Ace]) (Soft 12)
        , test "3 Aces" <|
            \_ ->
                Expect.equal (pointsForHand [Ace, Ace, Ace]) (Soft 13)
        , test "1 Jack, 1 Queen, 1 King" <|
            \_ ->
                Expect.equal (pointsForHand [Jack, Queen, King]) (Bust)
        , test "2 Aces, 1 Ten" <|
            \_ ->
                Expect.equal (pointsForHand [Ace, Ten, Ace]) (Hard 12)
        , test "1 Six, 1 Seven, 1 Eight" <|
            \_ ->
                Expect.equal (pointsForHand [Six, Seven, Eight]) (Hard 21)
        , test "1 Seven, 1 Eight, 1 Nine" <|
            \_ ->
                Expect.equal (pointsForHand [Seven, Eight, Nine]) (Bust)
        ]
        