module Haxis where
  import Graphics.Gloss

  data FunctionType = Linear Float Float | Quad Float Float Float deriving (Show, Eq)

  getFunc :: FunctionType -> Float -> Float
  getFunc (Linear m b) = (\x -> (m*x)+b)
  getFunc (Quad a b c) = (\x -> (a*x^2) + b*x + c)

  axis :: [(Float, Float)] -> [Picture]
  axis points = [translate 0 0 $ color red $ line [(0,0), (0, 500)], translate 0 0 $ color red $ line [(0,0), (500, 0)], translate 0 0 $ color red $ line [(0,0), (0, (-500))], translate 0 0 $ color red $ line [(0,0), ((-500), 0)]] ++ (xTicks points)

  xTicks :: [(Float, Float)] -> [Picture]
  xTicks points = map (\(x, y) -> translate 0 0 $ color red $ line [(x, y), (x, y+10)]) points

  render :: (Float -> Float) -> [Float] -> Picture
  render func ps = Pictures (axis [(x, y) | (x, y) <- zip [0..500] [0..0]] ++ plotPoints points func) 
    where
      points = calcPoints func ps

  calcPoints :: Num a => (a -> b) -> [a] -> [(a, b)]
  calcPoints func x = (zip n neg) ++ (zip x pos)
    where
      pos = map func x
      neg = map func n
      n = map negate x

  plotPoints :: [(Float, Float)] -> (Float -> Float) -> [Picture]
  plotPoints points func = ps ++ ls
    where
      ps = map (\(x, y) -> translate x y $ color white $ circle 0.1) points
      ls = map (\(x, y) -> translate 0 0 $ color white $ line [(x, y), (x+1, func (x+1))]) points

  drawPoints :: (Float -> Float) -> [Float] -> IO ()
  drawPoints func ps = display FullScreen black (render func ps)