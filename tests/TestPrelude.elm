module TestPrelude exposing (..)

import Test exposing (Test, describe, test)
import Expect
import Prelude


suite : Test
suite =
  describe "Prelude module"
    [ describe "Tuple utils"
      [ test "Prelude.fst" <| \_ -> Expect.equal 1 (Prelude.fst (1, 2))
      , test "Prelude.snd" <| \_ -> Expect.equal 2 (Prelude.snd (1, 2))
      , test "Prelude.fst3" <| \_ -> Expect.equal 1 (Prelude.fst3 (1, 2, 3))
      , test "Prelude.snd3" <| \_ -> Expect.equal 2 (Prelude.snd3 (1, 2, 3))
      , test "Prelude.thd3" <| \_ -> Expect.equal 3 (Prelude.thd3 (1, 2, 3))
      ]    
    ]

