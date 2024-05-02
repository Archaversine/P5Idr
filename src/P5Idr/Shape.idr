module P5Idr.Shape

public export
data Rect : Type where 
    MkRect : (x, y, w, h : Double) -> Rect

%foreign "javascript:lambda:(x,y,w,h)=>rect(x,y,w,h)"
prim__rect : Double -> Double -> Double -> Double -> PrimIO ()

export 
rect : HasIO io => Rect -> io ()
rect (MkRect x y w h) = primIO $ prim__rect x y w h