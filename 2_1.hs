import System.Environment
import Data.List.Split

requiredWrappingPaper :: (Int, Int, Int) -> Int
requiredWrappingPaper (l, w, h) | h <= w && w <= l = 2*l*w + 2*h*l + 3*w*h
                                | h > w            = requiredWrappingPaper (l, h, w)
                                | w > l            = requiredWrappingPaper (w, l, h)

parseLine :: String -> (Int, Int, Int)
parseLine input = (l, w, h)
  where [l, w, h] = map read (splitOn "x" input)

solve :: String -> IO ()
solve file = do
  input <- readFile file
  print (sum (map requiredWrappingPaper (map parseLine (lines input))))

main = do
  [file] <- getArgs
  solve file
