module P5Idr.Math.Types

%default total

public export
data PVector : Type where 
    Vector2 : (x, y    : Double) -> PVector
    Vector3 : (x, y, z : Double) -> PVector

public export
toVec2 : PVector -> PVector
toVec2 (Vector2 x y  ) = Vector2 x y
toVec2 (Vector3 x y z) = Vector2 x y

public export
toVec3 : PVector -> PVector 
toVec3 (Vector2 x y  ) = Vector3 x y 0 
toVec3 (Vector3 x y z) = Vector3 x y z

export
Num PVector where 
    Vector3 x1 y1 z1 + Vector3 x2 y2 z2 = Vector3 (x1 + x2) (y1 + y2) (z1 + z2)
    v1 + v2 = assert_total (toVec3 v1 + toVec3 v2)

    Vector2 x y   * Vector2 x' y'    = Vector2 (x * x') (y * y') 
    Vector2 x y   * Vector3 x' y' z  = Vector2 (x * x') (y * y') 
    Vector3 x y z * Vector2 x' y'    = Vector2 (x * x') (y * y') 
    Vector3 x y z * Vector3 x' y' z' = Vector3 (x * x') (y * y') (z * z')

    fromInteger i = let x = fromInteger i in Vector3 x x x

%foreign "javascript:lambda:(x1,y1,z1,x2,y2,z2)=>dist(x1,y1,z1,x2,y2,z2)"
prim__dist : (x1, y1, z1, x2, y2, z2 : Double) -> Double

public export
dist : PVector -> PVector -> Double
dist (Vector2 x1 y1)    (Vector2 x2 y2)    = prim__dist x1 y1 0  x2 y2 0
dist (Vector2 x1 y1)    (Vector3 x2 y2 z2) = prim__dist x1 y1 0  x2 y2 z2
dist (Vector3 x1 y1 z1) (Vector2 x2 y2)    = prim__dist x1 y1 z1 x2 y2 0
dist (Vector3 x1 y1 z1) (Vector3 x2 y2 z2) = prim__dist x1 y1 z1 x2 y2 z2

public export
mag : PVector -> Double
mag (Vector2 x y)   = sqrt (x * x + y * y)
mag (Vector3 x y z) = sqrt (x * x + y * y + z * z)

public export 
norm : PVector -> PVector
norm (Vector2 0 0)   = 0
norm (Vector3 0 0 0) = 0
norm (Vector2 x y)   = let m = mag (Vector2 x y) in Vector2 (x / m) (y / m)
norm (Vector3 x y z) = let m = mag (Vector3 x y z) in Vector3 (x / m) (y / m) (z / m)