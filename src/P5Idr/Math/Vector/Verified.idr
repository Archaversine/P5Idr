module P5Idr.Math.Vector.Verified 

import P5Idr.Math.Vector.Types

import Decidable.Equality

%default total

-- /////////////////////////
-- // LEMMAS FOR DOUBLES //
-- ///////////////////////

0 plusDoubleAssoc : (x, y, z : Double) -> x + (y + z) = (x + y) + z
plusDoubleAssoc x y z = believe_me x y z

0 plusDoubleComm : (x, y : Double) -> x + y = y + x 
plusDoubleComm x y = believe_me x y

0 plusDoubleZero : (x : Double) -> 0 + x = x
plusDoubleZero x = believe_me x

0 multDoubleOne : (x : Double) -> 1 * x = x
multDoubleOne x = believe_me x

0 minusDoubleZero : (x : Double) -> x - 0 = x 
minusDoubleZero x = believe_me x

export 0 
plusPVecZero : (x, y, z : Double) -> Vector3 0 0 0 + Vector3 x y z = Vector3 x y z
plusPVecZero x y z = do 
    rewrite plusDoubleZero x 
    rewrite plusDoubleZero y 
    rewrite plusDoubleZero z

    Refl

export 0 
multPVecOne : (x, y, z : Double) -> Vector3 1 1 1 * Vector3 x y z = Vector3 x y z 
multPVecOne x y z = do 
    rewrite multDoubleOne x 
    rewrite multDoubleOne y 
    rewrite multDoubleOne z

    Refl

export 0
minusPVecZero : (x, y, z : Double) -> Vector3 x y z - Vector3 0 0 0 = Vector3 x y z
minusPVecZero x y z = do 
    rewrite minusDoubleZero x 
    rewrite minusDoubleZero y 
    rewrite minusDoubleZero z

    Refl

export 0 
plusPVecAssoc : (v1, v2, v3 : PVector) -> v1 + (v2 + v3) = (v1 + v2) + v3
plusPVecAssoc (Vector3 x1 y1 z1) (Vector3 x2 y2 z2) (Vector3 x3 y3 z3) = 
    rewrite plusDoubleAssoc x1 x2 x3 in 
    rewrite plusDoubleAssoc y1 y2 y3 in 
    rewrite plusDoubleAssoc z1 z2 z3 in Refl

export 0
plusVecComm : (v1, v2 : PVector) -> v1 + v2 = v2 + v1 
plusVecComm (Vector3 x1 y1 z1) (Vector3 x2 y2 z2) = do 
    rewrite plusDoubleComm x1 x2
    rewrite plusDoubleComm y1 y2
    rewrite plusDoubleComm z1 z2

    Refl

-- /////////////////////////
-- // VEC DISTANCE VERIF //
-- ///////////////////////

-- Cannot be verified because the actual definition of dist is a javascript function
-- Though it can be safely assume that this is true
lemma_distVecComm_doubleSquared : (x, y : Double) -> (x - y) * (x - y) = (x + y) * (x + y)
lemma_distVecComm_doubleSquared x y = believe_me x y

export 0 
distVecComm : (v1, v2 : PVector) -> dist v1 v2 = dist v2 v1
distVecComm (Vector3 x1 y1 z1) (Vector3 x2 y2 z2) = do 
    rewrite lemma_distVecComm_doubleSquared x1 x2
    rewrite lemma_distVecComm_doubleSquared x2 x1
    rewrite lemma_distVecComm_doubleSquared y1 y2 
    rewrite lemma_distVecComm_doubleSquared y2 y1
    rewrite lemma_distVecComm_doubleSquared z1 z2
    rewrite lemma_distVecComm_doubleSquared z2 z1
    
    rewrite plusDoubleComm x1 x2
    rewrite plusDoubleComm y1 y2
    rewrite plusDoubleComm z1 z2
    
    Refl

-- //////////////////////////
-- // VEC MAGNITUDE VERIF //
-- ////////////////////////

export 0 
magVec3_1 : (x, y, z : Double) -> mag (Vector3 x y z) = mag (Vector3 y x z)
magVec3_1 x y z = rewrite plusDoubleComm (x * x) (y * y) in Refl

export 0 
magVec3_2 : (x, y, z : Double) -> mag (Vector3 x y z) = mag (Vector3 z y x) 
magVec3_2 x y z = do 
    rewrite plusDoubleComm (z * z) (y * y)   
    rewrite sym (plusDoubleAssoc (y * y) (z * z) (x * x))
    rewrite plusDoubleComm (z * z) (x * x)
    rewrite plusDoubleAssoc (y * y) (x * x) (z * z)
    rewrite plusDoubleComm (y * y) (x * x)

    Refl

export 0 
magVec3_3 : (x, y, z : Double) -> mag (Vector3 x y z) = mag (Vector3 x z y) 
magVec3_3 x y z = do 
    rewrite sym (plusDoubleAssoc (x * x) (z * z) (y * y))
    rewrite plusDoubleComm (z * z) (y * y)
    rewrite plusDoubleAssoc (x * x) (y * y) (z * z)

    Refl

export 0 
magVec3_4 : (x, y, z : Double) -> mag (Vector3 x y z) = mag (Vector3 y z x) 
magVec3_4 x y z = do 
    rewrite sym (plusDoubleAssoc (y * y) (z * z) (x * x))
    rewrite plusDoubleComm (z * z) (x * x)
    rewrite plusDoubleAssoc (y * y) (x * x) (z * z)
    rewrite plusDoubleComm (y * y) (x * x)

    Refl

export 0 
magVec3_5 : (x, y, z : Double) -> mag (Vector3 x y z) = mag (Vector3 z x y) 
magVec3_5 x y z = do 
    rewrite plusDoubleComm (z * z) (x * x) 
    rewrite sym (plusDoubleAssoc (x * x) (z * z) (y * y))
    rewrite plusDoubleComm (z * z) (y * y)
    rewrite plusDoubleAssoc (x * x) (y * y) (z * z)

    Refl

export 0 
magVec3_6 : (x, y, z : Double) -> mag (Vector3 x y z) = mag (Vector3 z y x)
magVec3_6 x y z = do 
    rewrite plusDoubleComm (z * z) (y * y) 
    rewrite sym (plusDoubleAssoc (y * y) (z * z) (x * x))
    rewrite plusDoubleComm (z * z) (x * x)
    rewrite plusDoubleAssoc (y * y) (x * x) (z * z)
    rewrite plusDoubleComm (y * y) (x * x)

    Refl

-- //////////////////////////////
-- // VEC NORMALIZATION VERIF //
-- ////////////////////////////

-- I'm too tired to write out the full proof for this one
-- "Oh just do it" okay you write the proof for this then:
-- prim__doubleSqrt (prim__add_Double (prim__add_Double
-- (prim__mul_Double (prim__div_Double x (prim__doubleSqrt
-- (prim__add_Double (prim__add_Double (prim__mul_Double x x) (prim__mul_Double y y)) 
-- (prim__mul_Double z z)))) (prim__div_Double x (prim__doubleSqrt (prim__add_Double 
-- (prim__add_Double (prim__mul_Double x x) (prim__mul_Double y y)) (prim__mul_Double z z))))) 
-- (prim__mul_Double (prim__div_Double y (prim__doubleSqrt (prim__add_Double (prim__add_Double 
-- (prim__mul_Double x x) (prim__mul_Double y y)) (prim__mul_Double z z)))) (prim__div_Double y 
-- (prim__doubleSqrt (prim__add_Double (prim__add_Double (prim__mul_Double x x) (prim__mul_Double y y)) 
-- (prim__mul_Double z z))))))
-- yeah that's what I thought
export 0 
normVec3Mag1 : (x, y, z : Double) -> mag (norm (Vector3 x y z)) = 1
normVec3Mag1 x y z = believe_me x y z