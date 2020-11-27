module Prelude.Maybe exposing (..)

{-| Extra Maybe functions.

@docs maybe, mapMaybe, catMaybes, isJust, isNothing

-}


{-| Takes a default value, a function, and a `Maybe` value. If the `Maybe` value
is `Nothing`, the function returns the default value. Otherwise, it applies the
function to the value inside the `Just` and returns the result.
-}
maybe : b -> (a -> b) -> Maybe a -> b
maybe default func val =
    case val of
        Nothing ->
            default

        Just x ->
            func x


{-| Version of map which throw out elements.
-}
mapMaybe : (a -> Maybe b) -> List a -> List b
mapMaybe f x =
    catMaybes <| List.map f x


{-| Takes a list of `Maybe` and returns a list of all the `Just` values.
-}
catMaybes : List (Maybe a) -> List a
catMaybes =
    List.filterMap identity


{-| Returns `True` if its argument is of the form `Just _`
-}
isJust : Maybe a -> Bool
isJust =
    (/=) Nothing


{-| Returns `True` if its argument is `Nothing`
-}
isNothing : Maybe a -> Bool
isNothing =
    not << isJust


join : Maybe (Maybe a) -> Maybe a
join x =
    case x of
        Just y ->
            y

        _ ->
            Nothing
