import System.Environment
import Data.Map

requiredWrappingPaper :: (Int, Int, Int) -> Int
requiredWrappingPaper (l, w, h) | h <= w && w <= l = 2*l*w + 2*h*l + 3*w*h
                                | h > w            = requiredWrappingPaper (l, h, w)
                                | w > l            = requiredWrappingPaper (w, l, h)

deliver :: (Int, Int) -> [Char] -> Map (Int, Int) Int
deliver (x, y) ('<':t) = insertWith (+) (x, y) 1 (deliver (x-1, y) t)
deliver (x, y) ('>':t) = insertWith (+) (x, y) 1 (deliver (x+1, y) t)
deliver (x, y) ('^':t) = insertWith (+) (x, y) 1 (deliver (x, y-1) t)
deliver (x, y) ('v':t) = insertWith (+) (x, y) 1 (deliver (x, y+1) t)
deliver (x, y) []      = insertWith (+) (x, y) 1 empty

solve :: String -> IO ()
solve file = do
  input <- readFile file
  print (size (deliver (0, 0) input))

main = do
  [file] <- getArgs
  solve file
