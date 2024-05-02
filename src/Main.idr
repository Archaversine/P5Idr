module Main

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

draw : IO ()
draw = P5Idr.Setup.draw $ do 
    background (Gray 0)

    stroke (Gray 255)
    fill (RGB 255 0 0)
    rect (MkRect 10 10 50 50)

main : IO ()
main = setup *> draw