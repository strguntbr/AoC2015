import System.Environment

move :: Char -> Int -> Int
move '(' floor = floor + 1
move ')' floor = floor - 1

gotoFloor :: Int -> [Char] -> Int
gotoFloor curFloor [] = curFloor
gotoFloor curFloor instructions = gotoFloor (move (head instructions) curFloor) (tail instructions)

solve :: String -> IO ()
solve file = do
  input <- readFile file
  print (gotoFloor 0 input)

main = do
  [file] <- getArgs
  solve file
