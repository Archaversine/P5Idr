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

public export 
data Ellipse : Type where
    MkCircle   : (x, y, r    : Double) -> Ellipse
    MkEllipse  : (x, y, w, h : Double) -> Ellipse
    MkEllipseV : (x, y, w, h : Double) -> (v : Nat) -> Ellipse

ellipseToTuple : Ellipse -> (Double, Double, Double, Double, Nat)
ellipseToTuple (MkCircle   x y r)     = (x, y, r, r, 25)
ellipseToTuple (MkEllipse  x y w h)   = (x, y, w, h, 25)
ellipseToTuple (MkEllipseV x y w h v) = (x, y, w, h, v)

%foreign "javascript:lambda:(x,y,w,h,v)=>ellipse(x,y,w,h,v)"
prim__ellipse : (x, y, w, h : Double) -> (v : Nat) -> PrimIO ()

export 
ellipse : HasIO io => Ellipse -> io () 
ellipse e = let (x, y, w, h, v) = ellipseToTuple e in primIO $ prim__ellipse x y w h v