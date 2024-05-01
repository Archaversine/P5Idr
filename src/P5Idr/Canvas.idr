module P5Idr.Canvas

%foreign "javascript:lambda:(w,h)=>createCanvas(w,h)"
prim__createCanvas : Int -> Int -> PrimIO ()

export 
createCanvas : HasIO io => Nat -> Nat -> io ()
createCanvas w h = primIO $ prim__createCanvas (cast w) (cast h)
