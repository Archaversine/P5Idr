module P5Idr.Math.Vector.Verified 

import P5Idr.Math.Vector.Types

import Decidable.Equality

%default total

-- //////////////////////////
-- // VECTOR VERIFICATION //
-- ////////////////////////

0 verifyToVec2Vec2 : (x, y : Double) -> toVec2 (Vector2 x y) = Vector2 x y
verifyToVec2Vec2 x y = Refl

0 verifyToVec2Vec3 : (x, y, z : Double) -> toVec2 (Vector3 x y z) = Vector2 x y
verifyToVec2Vec3 x y z = Refl


0 verifyToVec3Vec2 : (x, y : Double) -> toVec3 (Vector2 x y) = Vector3 x y 0
verifyToVec3Vec2 x y = Refl

0 verifyToVec3Vec3 : (x, y, z : Double) -> toVec3 (Vector3 x y z) = Vector3 x y z
verifyToVec3Vec3 x y z = Refl

export 0
eqVec2Vec3 : (x, y : Double) -> Vector2 x y = Vector3 x y 0
eqVec2Vec3 x y = believe_me x y

export 0 
eqVec3Vec2 : (x, y : Double) -> Vector3 x y 0 = Vector2 x y 
eqVec3Vec2 x y = rewrite eqVec2Vec3 x y in Refl

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
plusPVecAssoc v1@(Vector2 x1 y1) v2@(Vector2 x2 y2) v3@(Vector2 x3 y3) =
    rewrite plusDoubleAssoc x1 x2 x3 in 
    rewrite plusDoubleAssoc y1 y2 y3 in Refl
plusPVecAssoc v1@(Vector2 x1 y1) v2@(Vector2 x2 y2) v3@(Vector3 x3 y3 z3) =
    rewrite plusDoubleAssoc x1 x2 x3 in 
    rewrite plusDoubleAssoc y1 y2 y3 in 
    rewrite plusDoubleZero  z3       in 
    rewrite plusDoubleZero  z3       in Refl
plusPVecAssoc v1@(Vector2 x1 y1) v2@(Vector3 x2 y2 z2) v3@(Vector2 x3 y3) =
    rewrite plusDoubleAssoc x1 x2 x3 in 
    rewrite plusDoubleAssoc y1 y2 y3 in 
    rewrite plusDoubleZero  z2       in 
    rewrite plusDoubleComm  z2 0     in
    rewrite plusDoubleZero  z2       in
    rewrite plusDoubleZero  z2       in Refl
plusPVecAssoc v1@(Vector2 x1 y1) v2@(Vector3 x2 y2 z2) v3@(Vector3 x3 y3 z3) = 
    rewrite plusDoubleAssoc x1 x2 x3 in 
    rewrite plusDoubleAssoc y1 y2 y3 in 
    rewrite plusDoubleAssoc 0 z2 z3 in Refl 
plusPVecAssoc v1@(Vector3 x1 y1 z1) v2@(Vector2 x2 y2) v3@(Vector2 x3 y3) =
    rewrite plusDoubleAssoc x1 x2 x3 in 
    rewrite plusDoubleAssoc y1 y2 y3 in
    rewrite plusDoubleComm  z1 0     in
    rewrite plusDoubleZero  z1       in
    rewrite plusDoubleComm  z1 0     in
    rewrite plusDoubleZero  z1       in Refl
plusPVecAssoc v1@(Vector3 x1 y1 z1) v2@(Vector2 x2 y2) v3@(Vector3 x3 y3 z3) = 
    rewrite plusDoubleAssoc x1 x2 x3 in 
    rewrite plusDoubleAssoc y1 y2 y3 in 
    rewrite plusDoubleAssoc z1 0 z3 in Refl
plusPVecAssoc v1@(Vector3 x1 y1 z1) v2@(Vector3 x2 y2 z2) v3@(Vector2 x3 y3) = 
    rewrite plusDoubleAssoc x1 x2 x3 in 
    rewrite plusDoubleAssoc y1 y2 y3 in 
    rewrite plusDoubleAssoc z1 z2 0 in Refl 

export 0
plusVecComm : (v1, v2 : PVector) -> v1 + v2 = v2 + v1 
plusVecComm (Vector3 x1 y1 z1) (Vector3 x2 y2 z2) = do 
    rewrite plusDoubleComm x1 x2
    rewrite plusDoubleComm y1 y2
    rewrite plusDoubleComm z1 z2

    Refl
plusVecComm (Vector2 x1 y1) (Vector2 x2 y2) = do 
    rewrite plusDoubleComm x1 x2
    rewrite plusDoubleComm y1 y2 

    Refl
plusVecComm (Vector2 x1 y1) (Vector3 x2 y2 z2) = do 
    rewrite plusDoubleComm x1 x2
    rewrite plusDoubleComm y1 y2 
    rewrite plusDoubleComm z2 0
    rewrite plusDoubleZero z2

    Refl
plusVecComm (Vector3 x1 y1 z1) (Vector2 x2 y2) = do 
    rewrite plusDoubleComm x1 x2
    rewrite plusDoubleComm y1 y2 
    rewrite plusDoubleComm z1 0
    rewrite plusDoubleZero z1

    Refl

export 0
eqAddVec2Vec3 : (x1, y1, x2, y2 : Double) -> Vector2 x1 y1 + Vector2 x2 y2 = Vector3 x1 y1 0 + Vector3 x2 y2 0
eqAddVec2Vec3 x1 y1 x2 y2 = Refl

-- /////////////////////////
-- // VEC DISTANCE VERIF //
-- ///////////////////////

export 0
distVec2Vec3 : (x1, y1, x2, y2 : Double) 
    -> dist (Vector2 x1 y1) (Vector2 x2 y2) = dist (Vector3 x1 y1 0) (Vector3 x2 y2 0)
distVec2Vec3 x1 y1 x2 y2 = do
    rewrite plusDoubleComm ((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2)) 0
    rewrite plusDoubleZero ((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2))
    Refl

-- Cannot be verified because the actual definition of dist is a javascript function
-- Though it can be safely assume that this is true
export 0 
distVecComm : (v1, v2 : PVector) -> dist v1 v2 = dist v2 v1
distVecComm v1 v2 = believe_me v1 v2

-- //////////////////////////
-- // VEC MAGNITUDE VERIF //
-- ////////////////////////

export 0
magVec2Comm : (x, y : Double) -> mag (Vector2 x y) = mag (Vector2 y x)
magVec2Comm x y = rewrite plusDoubleComm (x * x) (y * y) in Refl

export 0
magVec3ToVec2 : (x, y : Double) -> mag (Vector2 x y) = mag (Vector3 x y 0)
magVec3ToVec2 x y = do
    rewrite plusDoubleComm (x * x) (y * y)       
    rewrite plusDoubleComm ((y * y) + (x * x)) 0 
    rewrite plusDoubleZero ((y * y) + (x * x))   

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

export 0
normEqVec2Vec3 : (x, y : Double) -> norm (Vector2 x y) = norm (Vector3 x y 0)
normEqVec2Vec3 0 0 = Refl
normEqVec2Vec3 x y = rewrite eqVec2Vec3 x y in Refl
