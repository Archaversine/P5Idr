module P5Idr.Shape

public export
data Rect : Type where 
    MkRect : (x, y, w, h : Double) -> Rect
    MkRoundRect : (x, y, w, h, b : Double) -> Rect

rectToTuple : Rect -> (Double, Double, Double, Double, Double) 
rectToTuple (MkRect x y w h) = (x, y, w, h, 0)
rectToTuple (MkRoundRect x y w h b) = (x, y, w, h, b)

%foreign "javascript:lambda:(x,y,w,h,b)=>rect(x,y,w,h,b)"
prim__rect : (x, y, w, h, b : Double) -> PrimIO ()

export 
rect : HasIO io => Rect -> io ()
rect r = let (x, y, w, h, b) = rectToTuple r in primIO $ prim__rect x y w h b