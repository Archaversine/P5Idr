module Main

import P5Idr.Setup
import P5Idr.Canvas

setup : IO ()
setup = P5Idr.Setup.setup $ do 
    createCanvas 400 400

draw : IO ()
draw = P5Idr.Setup.draw $ do 
    pure ()

main : IO ()
main = setup *> draw