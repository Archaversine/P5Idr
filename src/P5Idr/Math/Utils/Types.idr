module P5Idr.Math.Utils.Types

import public Data.So

public export
constrain : Ord a => (a, a) -> a -> a
constrain (lower, upper) value with (choose (value >= lower), choose (value <= upper))
    _ | (Left p1, Left p2) = value
    _ | (Right p1, _) = lower
    _ | (_, Right p2) = upper