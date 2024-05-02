module Main

import Data.Ref

import P5Idr.Setup
import P5Idr.Rendering
import P5Idr.Color
import P5Idr.Shape

setup : IO ()
setup = P5Idr.Setup.setup $ do 
    createCanvas 400 400

    width  <- getWidth  {ty=Nat}
    height <- getHeight {ty=Nat}

    putStrLn $ "Width: " ++ show width
    putStrLn $ "Height: " ++ show height

draw : IORef Double -> IO ()
draw xRef = P5Idr.Setup.draw $ do 
    background (Gray 0)

    width <- getWidth
    x     <- readRef xRef

    stroke (Gray 255)
    fill (RGB 255 0 0)
    rect (MkRect x 10 50 50)
    ellipse (MkCircle (x + 25) 100 50)

    if x > width then writeRef xRef (-50) else writeRef xRef (x + 1)

main : IO ()
main = do 
    x <- newRef 0

    setup *> draw x