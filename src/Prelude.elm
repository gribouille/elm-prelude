module Prelude exposing (const, uncurry3, curry3, iff)

{-| Extra standard functions.

@docs const, uncurry3, curry3, iff

-}

import Prelude.Maybe exposing (..)
import Prelude.Result exposing (..)
import Prelude.Tuple exposing (..)


{-| Unary function which evaluates to `x` for all inputs.
-}
const : a -> b -> a
const x =
    \_ -> x


{-| Converts a curried function with 3 parameters to a function on pairs.
-}
uncurry3 : (a -> b -> c -> d) -> ( a, b, c ) -> d
uncurry3 f ( x, y, z ) =
    f x y z


{-| Converts an uncurried function with 3 parameters to a curried function.
-}
curry3 : (( a, b, c ) -> d) -> a -> b -> c -> d
curry3 f x y z =
    f ( x, y, z )


{-| Short if statement.
-}
iff : Bool -> a -> a -> a
iff c t f =
    if c then
        t

    else
        f
