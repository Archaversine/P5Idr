module P5Idr.Math

import Data.So
import Decidable.Equality

import public P5Idr.Math.Vector.Types
import public P5Idr.Math.Vector.Verified

export
constrain : Ord a => (a, a) -> a -> a
constrain (lower, upper) value with (choose (value >= lower), choose (value <= upper))
    _ | (Left p1, Left p2) = value
    _ | (Right p1, _) = lower
    _ | (_, Right p2) = upper

export 0
verifyConstrain : Ord a => (low, up, val : a) 
    -> (p1 : So (val >= low)) 
    -> (p2 : So (val <= up)) 
    -> constrain (low, up) val = val
verifyConstrain low up val p1 p2 with (choose (val >= low), choose (val <= up))
    _ | (Left p3, Left p4) = Refl
    _ | (Right p3, _) = absurd (soNotToNotSo p3 p1)
    _ | (_, Right p4) = absurd (soNotToNotSo p4 p2)

export 0 
verifyConstrainLower : Ord a => (low, up, val : a) 
    -> (p1 : Not (So (val >= low)))
    -> (p2 : So (val <= up)) 
    -> constrain (low, up) val = low
verifyConstrainLower low up val p1 p2 with (choose (val >= low), choose (val <= up)) 
    _ | (Left p3, _) = absurd (p1 p3)
    _ | (Right p3, Left p4)  = Refl
    _ | (Right p3, Right p4) = Refl

export 0 
verifyConstrainUpper : Ord a => (low, up, val : a)
    -> (p1 : So (val >= low))
    -> (p2 : Not (So (val <= up))) 
    -> constrain (low, up) val = up 
verifyConstrainUpper low up val p1 p2 with (choose (val >= low), choose (val <= up))
    _ | (Right p3, _) = absurd (soNotToNotSo p3 p1)
    _ | (_, Left p3)  = absurd (p2 p3)
    _ | (Left p3, Right p4) = Refl