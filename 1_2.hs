import System.Environment

move :: Char -> Int -> Int
move '(' floor = floor + 1
move ')' floor = floor - 1

enterBasement :: Int -> [Char] -> Int
enterBasement curFloor instructions | curFloor < 0 = 0
                                    | otherwise    = enterBasement (move (head instructions) curFloor) (tail instructions) + 1

solve :: String -> IO ()
solve file = do
  input <- readFile file
  print( enterBasement 0 input )

main = do
  [file] <- getArgs
  solve file
