module P5Idr.Math.Vector.Types

%default total

public export
data PVector : Type where 
    Vector3 : (x, y, z : Double) -> PVector

Vector2 : (x, y : Double) -> PVector 
Vector2 x y = Vector3 x y 0

export
Num PVector where 
    Vector3 x1 y1 z1 + Vector3 x2 y2 z2 = Vector3 (x1 + x2) (y1 + y2) (z1 + z2)
    Vector3 x1 y1 z1 * Vector3 x2 y2 z2 = Vector3 (x1 * x2) (y1 * y2) (z1 * z2)

    fromInteger i = let x = fromInteger i in Vector3 x x x

export 
Neg PVector where
    negate (Vector3 x y z) = Vector3 (-x) (-y) (-z)

    Vector3 x1 y1 z1 - Vector3 x2 y2 z2 = Vector3 (x1 - x2) (y1 - y2) (z1 - z2) 

public export
dist : PVector -> PVector -> Double
dist (Vector3 x1 y1 z1) (Vector3 x2 y2 z2) = sqrt ((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2) + (z1 - z2) * (z1 - z2))

public export
mag : PVector -> Double
mag (Vector3 x y z) = sqrt (x * x + y * y + z * z)

public export 
norm : PVector -> PVector
norm (Vector3 0 0 0) = 0
norm (Vector3 x y z) = let m = mag (Vector3 x y z) in Vector3 (x / m) (y / m) (z / m)