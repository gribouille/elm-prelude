module Prelude.Result exposing (..)

{-| Extra Result functions.

@docs result, isOk, isErr, resultFlip, resultValues, resultErrors

-}

import Prelude.Maybe exposing (catMaybes)


{-| Case analysis for the `Result` type. If the value is `Err a`, apply the first
function to `a`; if it is `Ok b`, apply the second function to `b`.
-}
result : (a -> c) -> (b -> c) -> Result a b -> c
result f g r =
    case r of
        Ok value ->
            g value

        Err error ->
            f error


{-| True if the `Result` is an `Ok` value.
-}
isOk : Result a b -> Bool
isOk r =
    case r of
        Ok _ ->
            True

        Err _ ->
            False


{-| True if the `Result` is an `Err` value.
-}
isErr : Result a b -> Bool
isErr =
    not << isOk


{-| Flip the `Err` and `Ok` values.
-}
resultFlip : Result a b -> Result b a
resultFlip r =
    case r of
        Ok x ->
            Err x

        Err y ->
            Ok y


{-| Extracts from a list of `Result` all the `Err` elements.
-}
resultValues : List (Result a b) -> List b
resultValues =
    catMaybes << List.map Result.toMaybe


{-| Extracts from a list of `Result` all the `Ok` elements.
-}
resultErrors : List (Result a b) -> List a
resultErrors =
    resultValues << List.map resultFlip
