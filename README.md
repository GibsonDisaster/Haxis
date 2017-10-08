# Haxis

## Use
As of right now there is only a simple plotting function you can use to plot either a linear or quadratic equation and a set of points to the graph.

## Example
To plot a normal quadratic you would use the drawPoints 
( FunctionType -> [Float] -> IO () ) function like so:

```haskell
module Main where
  import Haxis

  main :: IO ()
  main = drawPoints (Quad 1 0 0) [1..20]
```
this would plot the graph quadratically and from -20 to 20

## Dependancies
There is only one dependancy and that is the Gloss package which can be found on hackage. I did not create or contribute at all to Gloss, I am only building off of it.