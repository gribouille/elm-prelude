module Prelude exposing (..)

{-| Extra standard functions.

## Tuples

@docs fst, snd, fst3, snd3, thd3

-}

{-| Alias of `Tuple.first`-}
fst : (a1, a2) -> a1
fst = Tuple.first

{-| Alias of `Tuple.second`.-}
-- 
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

