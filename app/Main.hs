module Main (main) where

import           Lib (Robot (..), tournament)

-- | Run a tournament between two robots and print the results.
go :: String    -- message to print before the results
      -> Robot  -- attacking Robot
      -> Robot  -- defending Robot
      -> IO ()
go m r1 r2 = putStrLn m >> mapM_ print (tournament r1 r2)

-- | Uncurry a function of three arguments.
uncurry3 :: (a -> b -> c -> d) -> (a, b, c) -> d
uncurry3 f (x, y, z) = f x y z

-- | Run tournaments.
main :: IO ()
main =
  let
    fastRobot = Robot "fast"  7 40
    slowRobot = Robot "slow" 15 30
    tournaments = [("slow attacking fast", slowRobot, fastRobot)
                 , ("fast attacking slow", fastRobot, slowRobot)]
  in
    mapM_ (uncurry3 go) tournaments
