module TestPrelude exposing (suite)

import Test exposing (Test, describe, test)
import Expect exposing (equal, equalLists)
import Prelude




suite : Test
suite =
  describe "Prelude module"
    [ describe "Tuple utils"
        [ test "Prelude.fst"  <| \_ -> equal 1 (Prelude.fst (1, 2))
        , test "Prelude.snd"  <| \_ -> equal 2 (Prelude.snd (1, 2))
        , test "Prelude.fst3" <| \_ -> equal 1 (Prelude.fst3 (1, 2, 3))
        , test "Prelude.snd3" <| \_ -> equal 2 (Prelude.snd3 (1, 2, 3))
        , test "Prelude.thd3" <| \_ -> equal 3 (Prelude.thd3 (1, 2, 3))
        ]
    , describe "Maybe utils"
        [ test "Prelude.maybe unwrap"     <| \_ -> equal "3" (Prelude.maybe "no" toString (Just 3))
        , test "Prelude.maybe default"    <| \_ -> equal "no" (Prelude.maybe "no" toString Nothing)
        , test "Prelude.catMaybes"        <| \_ -> equalLists [3, 4, 2] (Prelude.catMaybes [Just 3, Nothing, Just 4, Just 2])
        , test "Prelude.mapMaybe"         <| \_ -> equalLists [2, 4, 2] (Prelude.mapMaybe (div 8) [4, 0, 2, 4])
        , test "Prelude.isJust true"      <| \_ -> equal True (Prelude.isJust (Just 3))
        , test "Prelude.isJust false"     <| \_ -> equal False (Prelude.isJust Nothing)
        , test "Prelude.isNothing false"  <| \_ -> equal False (Prelude.isNothing (Just 3))
        , test "Prelude.isNothing true"   <| \_ -> equal True (Prelude.isNothing Nothing)
        ]
    , describe "Result utils"
        [ test "Prelude.result ok"  <| \_ -> equal "-> test" (Prelude.result (((+)1) >> toString) ((++) "-> ") (Ok "test")) 
        , test "Prelude.result err" <| \_ -> equal "2" (Prelude.result (((+)1) >> toString) ((++) "-> ") (Err 1)) 
        , test "Prelude.isOk true"  <| \_ -> equal True (Prelude.isOk (Ok 3)) 
        , test "Prelude.isOk false"  <| \_ -> equal False (Prelude.isOk (Err 3)) 
        , test "Prelude.isErr true"  <| \_ -> equal False (Prelude.isErr (Ok 3)) 
        , test "Prelude.isErr false"  <| \_ -> equal True (Prelude.isErr (Err 3)) 
        , test "Prelude.resultValues" <| \_ -> equalLists [3,7] (Prelude.resultValues l1)
        , test "Prelude.resultErrors" <| \_ -> equalLists ["foo","bar","baz"] (Prelude.resultErrors l1)
        ]
    , describe "Other utils"
        [ test "Prelude.const int" <| \_ -> equal 43 (Prelude.const 43 88)
        , test "Prelude.const str" <| \_ -> equal "a" (Prelude.const "a" "b")
        ]
    ]

div : Float -> Float -> Maybe Float
div x y = if y == 0 then Nothing else Just (x / y)


l1 : List (Result String Int)
l1 = [ Err "foo", Ok 3, Err "bar", Ok 7, Err "baz" ]