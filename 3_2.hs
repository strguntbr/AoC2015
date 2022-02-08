import System.Environment
import Data.Map

requiredWrappingPaper :: (Int, Int, Int) -> Int
requiredWrappingPaper (l, w, h) | h <= w && w <= l = 2*l*w + 2*h*l + 3*w*h
                                | h > w            = requiredWrappingPaper (l, h, w)
                                | w > l            = requiredWrappingPaper (w, l, h)

deliver :: Int -> (Int, Int) -> (Int, Int) -> [Char] -> Map (Int, Int) Int
deliver 0 (x0, y0) (x1, y1) ('<':t) = insertWith (+) (x0, y0) 1 (deliver 1 (x0-1, y0) (x1, y1) t)
deliver 0 (x0, y0) (x1, y1) ('>':t) = insertWith (+) (x0, y0) 1 (deliver 1 (x0+1, y0) (x1, y1) t)
deliver 0 (x0, y0) (x1, y1) ('^':t) = insertWith (+) (x0, y0) 1 (deliver 1 (x0, y0-1) (x1, y1) t)
deliver 0 (x0, y0) (x1, y1) ('v':t) = insertWith (+) (x0, y0) 1 (deliver 1 (x0, y0+1) (x1, y1) t)
deliver 1 (x0, y0) (x1, y1) ('<':t) = insertWith (+) (x1, y1) 1 (deliver 0 (x0, y0) (x1-1, y1) t)
deliver 1 (x0, y0) (x1, y1) ('>':t) = insertWith (+) (x1, y1) 1 (deliver 0 (x0, y0) (x1+1, y1) t)
deliver 1 (x0, y0) (x1, y1) ('^':t) = insertWith (+) (x1, y1) 1 (deliver 0 (x0, y0) (x1, y1-1) t)
deliver 1 (x0, y0) (x1, y1) ('v':t) = insertWith (+) (x1, y1) 1 (deliver 0 (x0, y0) (x1, y1+1) t)
deliver _ (x0, y0) (x1, y1) []      = insertWith (+) (x0, y0) 1 (insertWith (+) (x1, y1) 1 empty)

solve :: String -> IO ()
solve file = do
  input <- readFile file
  print (size (deliver 0 (0, 0) (0, 0) input))

main = do
  [file] <- getArgs
  solve file
