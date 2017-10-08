module Haxis where
  import Graphics.Gloss

  data FunctionType = Linear Float Float | Quad Float Float Float deriving (Show, Eq)

  getFunc :: FunctionType -> Float -> Float
  getFunc (Linear m b) = (\x -> (m*x)+b)
  getFunc (Quad a b c) = (\x -> (a*x^2) + b*x + c)

  axis :: [Picture]
  axis = [translate 0 0 $ color red $ line [(0,0), (0, 500)], translate 0 0 $ color red $ line [(0,0), (500, 0)], translate 0 0 $ color red $ line [(0,0), (0, (-500))], translate 0 0 $ color red $ line [(0,0), ((-500), 0)]]

  render :: FunctionType -> [Float] -> Picture
  render func ps = Pictures (axis ++ plotPoints (calcPoints (getFunc func) ps))

  calcPoints :: Num a => (a -> b) -> [a] -> [(a, b)]
  calcPoints func x = (zip n neg) ++ (zip x pos)
    where
      pos = map func x
      neg = map func n
      n = map negate x

  plotPoints :: [(Float, Float)] -> [Picture]
  plotPoints points = ps ++ ls
    where
      ps = map (\(x, y) -> translate x y $ color white $ circle 1) points
      ls = map (\(x, y) -> translate 0 0 $ color white $ line [(x, y), (x+1, (x+1)^2)]) points

  drawPoints :: FunctionType -> [Float] -> IO ()
  drawPoints ft ps = display FullScreen black (render ft ps)