module P5Idr.Color

public export
data Color : Type where 
    Gray : (gray : Bits8)       -> Color
    RGB  : (r, g, b : Bits8)    -> Color
    RGBA : (r, g, b, a : Bits8) -> Color

export 
colorToTuple : Color -> (Bits8, Bits8, Bits8, Bits8)
colorToTuple (Gray gray)    = (gray, gray, gray, 255)
colorToTuple (RGB r g b)    = (r, g, b, 255) 
colorToTuple (RGBA r g b a) = (r, g, b, a)

%foreign "javascript:lambda:(r,g,b,a)=>background(color(r,g,b,a))"
prim__background : Bits8 -> Bits8 -> Bits8 -> Bits8 -> PrimIO ()

export 
background : HasIO io => Color -> io ()
background color = let (r, g, b, a) = colorToTuple color in 
    primIO $ prim__background r g b a 

%foreign "javascript:lambda:()=>width"
prim__getWidth : PrimIO Integer

export 
getWidth : (HasIO io, Num ty) => io ty 
getWidth = fromInteger <$> primIO prim__getWidth

%foreign "javascript:lambda:()=>height" 
prim__getHeight : PrimIO Integer 

export 
getHeight : (HasIO io, Num ty) => io ty 
getHeight = fromInteger <$> primIO prim__getHeight

%foreign "javascript:lambda:(r,g,b,a)=>fill(color(r,g,b,a))" 
prim__fill : Bits8 -> Bits8 -> Bits8 -> Bits8 -> PrimIO () 

export 
fill : HasIO io => Color -> io () 
fill color = let (r, g, b, a) = colorToTuple color in 
    primIO $ prim__fill r g b a

%foreign "javascript:lambda:()=>noFill()"
prim__noFill : PrimIO ()

export 
noFill : HasIO io => io ()
noFill = primIO prim__noFill

%foreign "javascript:lambda:(r,g,b,a)=>stroke(color(r,g,b,a))"
prim__stroke : Bits8 -> Bits8 -> Bits8 -> Bits8 -> PrimIO () 

export 
stroke : HasIO io => Color -> io () 
stroke color = let (r, g, b, a) = colorToTuple color in 
    primIO $ prim__stroke r g b a

%foreign "javascript:lambda:()=>noStroke()" 
prim__noStroke : PrimIO () 

export 
noStroke : HasIO io => io () 
noStroke = primIO prim__noStroke

%foreign "javascript:lambda:w=>strokeWeight(w)"
prim__strokeWeight : Bits8 -> PrimIO ()

export 
strokeWeight : HasIO io => Bits8 -> io () 
strokeWeight w = primIO $ prim__strokeWeight w