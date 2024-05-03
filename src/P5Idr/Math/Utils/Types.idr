module P5Idr.Math.Utils.Types

import public Data.So

public export
constrain : Ord a => (a, a) -> a -> a
constrain (lower, upper) value with (choose (value >= lower), choose (value <= upper))
    _ | (Left p1, Left p2) = value
    _ | (Right p1, _) = lower
    _ | (_, Right p2) = upper

%foreign "javascript:lambda:(start,stop,amt)=>lerp(start,stop,amt)"
prim__lerp : Double -> Double -> Double -> Double

export 
lerp : (Double, Double) -> Double -> Double
lerp (start, stop) amt = prim__lerp start stop amt