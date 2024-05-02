module P5Idr.Setup

import Control.Monad.Reader

%foreign "javascript:lambda:f=>setup=f"
prim__setup : IO () -> PrimIO ()

export
setup : HasIO io => (f : IO ()) -> io ()
setup = primIO . prim__setup

export 
setupWith : HasIO io => r -> (f : ReaderT r IO ()) -> io ()
setupWith r f = setup (runReaderT r f)

%foreign "javascript:lambda:f=>draw=f"
prim_draw : IO () -> PrimIO ()

export
draw : HasIO io => (f : IO ()) -> io () 
draw = primIO . prim_draw

export
drawWith : HasIO io => r -> (f : ReaderT r IO ()) -> io ()
drawWith r f = draw (runReaderT r f)