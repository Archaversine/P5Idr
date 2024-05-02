module P5Idr.Color

public export
data Color : Type where 
    Gray : (gray : Bits8)       -> Color
    RGB  : (r, g, b : Bits8)    -> Color
    RGBA : (r, g, b, a : Bits8) -> Color

    Red     : Color
    Orange  : Color
    Yellow  : Color
    Green   : Color 
    Blue    : Color 
    Magenta : Color
    White   : Color
    Black   : Color

export 
colorToTuple : Color -> (Bits8, Bits8, Bits8, Bits8)
colorToTuple c = case c of 
    Gray g       => (g  , g  , g  , 255)
    RGB  r g b   => (r  , g  , b  , 255)
    RGBA r g b a => (r  , g  , b  , a  )
    Red          => (255, 0  , 0  , 255)
    Orange       => (255, 165, 0  , 255)
    Yellow       => (255, 255, 0  , 255)
    Green        => (0  , 255, 0  , 255)
    Blue         => (0  , 0  , 255, 255)
    Magenta      => (255, 0  , 255, 255)
    White        => (255, 255, 255, 255)
    Black        => (0  , 0  , 0  , 255)

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