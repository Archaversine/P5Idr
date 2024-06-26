module P5Idr.Rendering

%foreign "javascript:lambda:(w,h)=>createCanvas(w,h)"
prim__createCanvas : Int -> Int -> PrimIO ()

export 
createCanvas : HasIO io => (width : Nat) -> (height : Nat) -> io ()
createCanvas w h = primIO $ prim__createCanvas (cast w) (cast h)
