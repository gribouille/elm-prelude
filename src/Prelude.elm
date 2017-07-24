module Prelude exposing (
  fst, snd, fst3, snd3, thd3,
  maybe, mapMaybe, catMaybes, isJust, isNothing,
  result, isOk, isErr, resultFlip, resultValues, resultErrors,
  const, uncurry3, curry3
)

{-| Extra standard functions.

## Tuples

@docs fst, snd, fst3, snd3, thd3

## Maybe

@docs maybe, mapMaybe, catMaybes, isJust, isNothing

## Result

@docs result, isOk, isErr, resultFlip, resultValues, resultErrors

## Other

@docs const, uncurry3, curry3

-}


-- TUPLE

{-| Alias of `Tuple.first`-}
fst : (a1, a2) -> a1
fst = Tuple.first


{-| Alias of `Tuple.second`.-}
snd : (a1, a2) -> a2
snd = Tuple.second


{-| Extract the first component of a triplet.-}
fst3 : (a1, a2, a3) -> a1
fst3 (x, _, _) = x


{-| Extract the second component of a triplet.-}
snd3 : (a1, a2, a3) -> a2
snd3 (_, x, _) = x


{-| Extract the third component of a triplet.-}
thd3 : (a1, a2, a3) -> a3
thd3 (_, _, x) = x



-- MAYBE

{-| Takes a default value, a function, and a `Maybe` value. If the `Maybe` value 
is `Nothing`, the function returns the default value. Otherwise, it applies the 
function to the value inside the `Just` and returns the result.-}
maybe : b -> (a -> b) -> Maybe a -> b
maybe default func val = 
  case val of Nothing -> default
              Just x -> func x


{-| Version of map which throw out elements. -}
mapMaybe : (a -> Maybe b) -> List a -> List b
mapMaybe f x = catMaybes <| List.map f x


{-| Takes a list of `Maybe` and returns a list of all the `Just` values. -}
catMaybes : List (Maybe a) -> List (a)
catMaybes = List.filterMap identity


{-| Returns `True` if its argument is of the form `Just _` -}
isJust : Maybe a -> Bool
isJust = (/=) Nothing


{-| Returns `True` if its argument is `Nothing` -}
isNothing : Maybe a -> Bool
isNothing = not << isJust



-- RESULTS

{-| Case analysis for the `Result` type. If the value is `Err a`, apply the first 
function to `a`; if it is `Ok b`, apply the second function to `b`. -}
result : (a -> c) -> (b -> c) -> Result a b -> c
result f g r = case r of (Ok value) -> g value
                         (Err error) -> f error


{-| True if the `Result` is an `Ok` value. -}
isOk : Result a b -> Bool
isOk r = case r of (Ok _) -> True
                   (Err _) -> False


{-| True if the `Result` is an `Err` value. -}
isErr : Result a b -> Bool
isErr = not << isOk


{-| Flip the `Err` and `Ok` values. -}
resultFlip : Result a b -> Result b a
resultFlip r = case r of (Ok x) -> Err x
                         (Err y) -> Ok y


{-| Extracts from a list of `Result` all the `Err` elements. -}
resultValues : List (Result a b) -> List b
resultValues = catMaybes << List.map Result.toMaybe


{-| Extracts from a list of `Result` all the `Ok` elements. -}
resultErrors : List (Result a b) -> List a
resultErrors = resultValues << List.map resultFlip



-- OTHER

{-| Unary function which evaluates to `x` for all inputs. -}
const : a -> b -> a
const x = \_ -> x


{-| Converts a curried function with 3 parameters to a function on pairs. -}
uncurry3 : (a -> b -> c -> d) -> (a, b, c) -> d
uncurry3 f (x, y, z) = f x y z


{-| Converts an uncurried function with 3 parameters to a curried function. -}
curry3 : ((a, b, c) -> d) -> a -> b -> c -> d
curry3 f x y z = f (x, y, z)