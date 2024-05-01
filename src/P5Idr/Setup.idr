module P5Idr.Setup

%foreign "javascript:lambda:f=>setup=f"
prim__setup : IO () -> PrimIO ()

export
setup : HasIO io => IO () -> io ()
setup = primIO . prim__setup

%foreign "javascript:lambda:f=>draw=f"
prim_draw : IO () -> PrimIO ()

export
draw : HasIO io => IO () -> io () 
draw = primIO . prim_draw