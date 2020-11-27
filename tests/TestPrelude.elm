module TestPrelude exposing (suite)

import Expect exposing (equal, equalLists)
import Prelude
import Prelude.Maybe
import Prelude.Result
import Prelude.Tuple
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Prelude module"
        [ describe "Tuple utils"
            [ test "Prelude.Tuple.fst" <| \_ -> equal 1 (Prelude.Tuple.fst ( 1, 2 ))
            , test "Prelude.Tuple.snd" <| \_ -> equal 2 (Prelude.Tuple.snd ( 1, 2 ))
            , test "Prelude.Tuple.fst3" <| \_ -> equal 1 (Prelude.Tuple.fst3 ( 1, 2, 3 ))
            , test "Prelude.Tuple.snd3" <| \_ -> equal 2 (Prelude.Tuple.snd3 ( 1, 2, 3 ))
            , test "Prelude.Tuple.thd3" <| \_ -> equal 3 (Prelude.Tuple.thd3 ( 1, 2, 3 ))
            ]
        , describe "Maybe utils"
            [ test "Prelude.Maybe.maybe unwrap" <| \_ -> equal "3" (Prelude.Maybe.maybe "no" String.fromInt (Just 3))
            , test "Prelude.Maybe.maybe default" <| \_ -> equal "no" (Prelude.Maybe.maybe "no" String.fromInt Nothing)
            , test "Prelude.Maybe.catMaybes" <| \_ -> equalLists [ 3, 4, 2 ] (Prelude.Maybe.catMaybes [ Just 3, Nothing, Just 4, Just 2 ])
            , test "Prelude.Maybe.mapMaybe" <| \_ -> equalLists [ 2, 4, 2 ] (Prelude.Maybe.mapMaybe (div 8) [ 4, 0, 2, 4 ])
            , test "Prelude.Maybe.isJust true" <| \_ -> equal True (Prelude.Maybe.isJust (Just 3))
            , test "Prelude.Maybe.isJust false" <| \_ -> equal False (Prelude.Maybe.isJust Nothing)
            , test "Prelude.Maybe.isNothing false" <| \_ -> equal False (Prelude.Maybe.isNothing (Just 3))
            , test "Prelude.Maybe.isNothing true" <| \_ -> equal True (Prelude.Maybe.isNothing Nothing)
            ]
        , describe "Result utils"
            [ test "Prelude.Result.result ok" <| \_ -> equal "-> test" (Prelude.Result.result ((+) 1 >> String.fromInt) ((++) "-> ") (Ok "test"))
            , test "Prelude.Result.result err" <| \_ -> equal "2" (Prelude.Result.result ((+) 1 >> String.fromInt) ((++) "-> ") (Err 1))
            , test "Prelude.Result.isOk true" <| \_ -> equal True (Prelude.Result.isOk (Ok 3))
            , test "Prelude.Result.isOk false" <| \_ -> equal False (Prelude.Result.isOk (Err 3))
            , test "Prelude.Result.isErr true" <| \_ -> equal False (Prelude.Result.isErr (Ok 3))
            , test "Prelude.Result.isErr false" <| \_ -> equal True (Prelude.Result.isErr (Err 3))
            , test "Prelude.Result.resultValues" <| \_ -> equalLists [ 3, 7 ] (Prelude.Result.resultValues l1)
            , test "Prelude.Result.resultErrors" <| \_ -> equalLists [ "foo", "bar", "baz" ] (Prelude.Result.resultErrors l1)
            ]
        , describe "Other utils"
            [ test "Prelude.const int" <| \_ -> equal 43 (Prelude.const 43 88)
            , test "Prelude.const str" <| \_ -> equal "a" (Prelude.const "a" "b")
            ]
        ]


div : Float -> Float -> Maybe Float
div x y =
    if y == 0 then
        Nothing

    else
        Just (x / y)


l1 : List (Result String Int)
l1 =
    [ Err "foo", Ok 3, Err "bar", Ok 7, Err "baz" ]
