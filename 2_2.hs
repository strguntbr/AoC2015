import System.Environment
import Data.List.Split

requiredRibbon :: (Int, Int, Int) -> Int
requiredRibbon (l, w, h) | h <= w && w <= l = 2*h + 2*w + h*w*l
                         | h > w            = requiredRibbon (l, h, w)
                         | w > l            = requiredRibbon (w, l, h)

parseLine :: String -> (Int, Int, Int)
parseLine input = (l, w, h)
  where [l, w, h] = map read (splitOn "x" input)

solve :: String -> IO ()
solve file = do
  input <- readFile file
  print (sum (map requiredRibbon (map parseLine (lines input))))

main = do
  [file] <- getArgs
  solve file
